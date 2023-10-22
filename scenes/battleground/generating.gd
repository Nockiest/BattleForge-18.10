extends BattlegroundState


var town_scene: PackedScene = preload("res://structures/town.tscn")
var player_scene: PackedScene = preload("res://player.tscn")
var supply_depo_scene: PackedScene = preload("res://structures/supply_depo.tscn")
var river_scene: PackedScene = preload("res://structures/river.tscn")
var forrest_scene:PackedScene = preload("res://structures/forrest/forrest.tscn")
var road_scene:PackedScene = preload("res://structures/road/road.tscn")
var bridge_scene:PackedScene = preload("res://structures/bridge.tscn")
# Reference to the state machine, to call its `transition_to()` method directly.
# That's one unorthodox detail of our state implementation, as it adds a dependency between the
# state and the state machine objects, but we found it to be most efficient for our needs.
 
 
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg := {}) -> void:
	print("ENTERED GENERATING STATE")
	Globals.tenders = get_tree().get_nodes_in_group("player_tenders")
	LoadingScreen.render_loading_screen()
	place_towns()
	create_roads_to_edges()
	process_place_units()
	place_forests()
	place_rivers()
	call_deferred_thread_group("add_bridges")
	create_roads_to_edges()
	LoadingScreen.hige_loading_screen() 
	state_machine.transition_to("Idle" ) 

func place_forests():
	for i in range(Globals.num_forests):
		var forrest_instance = forrest_scene.instantiate() as Node2D
		root.get_node("Structures").add_child(forrest_instance)
## CURRENTLY UNUSED
func place_supply_depos():
	for i in range(2):
		var supply_depo_instance = supply_depo_scene.instantiate() as Area2D
		supply_depo_instance.global_position =  Vector2(randf_range(200, get_viewport().size.x-200 ), randf_range(100, get_viewport().size.y-100))
		root.get_node("Structures").add_child(supply_depo_instance)
func place_towns():
	var town_place_tries = 0
	var max_placement_tries = 100
	var placement_positions= []
	while  town_place_tries < max_placement_tries and Globals.num_towns > len(get_tree().get_nodes_in_group("towns")):
		var new_point = Vector2(randf_range(25, get_viewport().size.x-150 ), randf_range(25, get_viewport().size.y-150))# Utils.get_random_point_in_square(placment_area.get_node("CollisionShape2D").shape.extents*2)
		var valid_position = true
		for point in placement_positions:
			if not Utils.are_points_far_enough(point, new_point, 150):
				valid_position = false
				break
		if valid_position:
			placement_positions.append(new_point)
			var town_instance = town_scene.instantiate() as Area2D
			town_instance.global_position = new_point #Vector2(randf_range(750, get_viewport().size.x-75 ), randf_range(25, get_viewport().size.y-25))
			root.get_node("Structures").add_child(town_instance)
		town_place_tries+=1
 
	for town in get_tree().get_nodes_in_group("towns"):
		town.connect_to_other_towns()
		for other_town in town.connected_towns:
			instantiate_roads(Utils.get_collision_shape_center(town  ), Utils.get_collision_shape_center(other_town ))


func place_rivers():
	var all_segments = []
	for i in range(Globals.num_rivers):
		var top_point =  Vector2(randi_range(100, get_viewport().size.x  -100), -20)
		var right_point =  Vector2(  get_viewport().size.x+20  , randi_range(100,  get_viewport().size.y -100))
		var left_point =  Vector2( -20 , randi_range(100,  get_viewport().size.y -100 ))
		var bottom_point =  Vector2(randi_range(100,  get_viewport().size.x -100 ),    get_viewport().size.y +20)		
		
		var start_point = top_point if randi() % 2 == 0 else left_point
		var end_point = bottom_point if randi() % 2 == 0 else right_point
		var control_point =  Vector2(randi_range(100, get_viewport().size.x-100), randi_range(100, get_viewport().size.y-100))
		
		var new_segments = Utils.generate_bezier_curve(start_point, end_point, control_point, 50)
		var non_intersecting_segments = []
		var intersecting_segment 
		for segment in new_segments:
			for existing_segment in all_segments:
				if Utils.do_lines_intersect(segment[0], segment[1], existing_segment[0], existing_segment[1])  :
					#print("SEGMENTS INTERSECTING", segment[0], segment[1], existing_segment[0], existing_segment[1] )
					intersecting_segment = segment
					non_intersecting_segments.append([segment[1], existing_segment[0]])
			if intersecting_segment:
				break
			non_intersecting_segments.append(segment)
#		if intersecting_segment:
#			print(len(non_intersecting_segments), len(new_segments))
		for segment in non_intersecting_segments:
			all_segments.append(segment  )
		var river_instance = river_scene.instantiate() as Node2D
		for segment in non_intersecting_segments:
			river_instance.add_river_segment(segment[0], segment[1]   )
		root.get_node("Structures").add_child(river_instance)

func process_place_units():
	call_deferred_thread_group("place_starting_units",root.get_node("RedBuyArea"), "red", Globals.red_player_units )  
	call_deferred_thread_group("place_starting_units",root.get_node("BlueBuyArea"), "blue", Globals.blue_player_units )
 
 
func place_starting_units(placment_area: Area2D, color, units_list  ):
	var total_unit_number = Utils.sum_dict_values(units_list)
	var placement_positions = []
	var minimal_gap = 65
	var tries = 0
	var max_tries = 1000
	var enlarged_areas = get_tree().get_nodes_in_group("enlarged_river_collision_areas")  
 
	while len(placement_positions) < total_unit_number and tries < max_tries:
		var new_point = Utils.get_random_point_in_square(placment_area.get_node("CollisionShape2D").shape.extents*2)
		var valid_position = true
		for point in placement_positions:
			if not Utils.are_points_far_enough(point, new_point, minimal_gap):
				valid_position = false
				break
		if not valid_position:
			tries+=1
			continue
		for segment in enlarged_areas:
			var global_new_point = placment_area.global_position + new_point
			var res = Utils.calculate_is_inside(segment, global_new_point) 
			if res:
				valid_position= false
				print("CANT PLACE IT ON POINT", new_point )
				break
 
		if valid_position:
			placement_positions.append(new_point)
		tries += 1
 
	for i in range(len(placement_positions)):
		placement_positions[i] += placment_area.global_position
	
	var i = 0
	for unit_name in units_list.keys():
		var unit_count = units_list[unit_name] 
		while unit_count > 0 and len(placement_positions) > 0:
			var random_index = randi() % (len(placement_positions ))
			var random_point = placement_positions[random_index]
 
			var instance = Globals.unit_packed_scenes_arr[i].instantiate() as Node2D
			instance.position = random_point
			instance.color = Color(color)
			instance.add_to_team(color)
			instance.is_newly_bought = false
			root.get_node("LivingUnits").add_child(instance)
			placement_positions.erase(random_point)
			unit_count -= 1
		i += 1
		
 
func create_roads_to_edges():	
	var top_point =  Vector2(randi_range(100, get_viewport().size.x  -100), 0)
	var right_point =  Vector2(  get_viewport().size.x  , randi_range(100,  get_viewport().size.y -100))
	var left_point =  Vector2( 0 , randi_range(100,  get_viewport().size.y -100 ))
	var bottom_point =  Vector2(randi_range(100,  get_viewport().size.x -100 ),    get_viewport().size.y )		
	var edge_points = [top_point,right_point,left_point,bottom_point]
	for edge_point in edge_points:
		var closest_town_center_pos
		for town in get_tree().get_nodes_in_group("towns"):
			if closest_town_center_pos == null:
				closest_town_center_pos = Utils. get_collision_shape_center(town )  
			elif Utils. get_collision_shape_center(town ).distance_to(edge_point) < closest_town_center_pos.distance_to(edge_point):
				closest_town_center_pos = Utils. get_collision_shape_center(town ) 
		if closest_town_center_pos == null:
			return
		instantiate_roads(closest_town_center_pos, edge_point)
 
 
func add_bridges():
	for river in get_tree().get_nodes_in_group("rivers"):
		var has_crossing = false
		for segment in river.get_children():
			if has_crossing:
				break
#			print(segment.get_node("Area2D").get_overlapping_areas())
			for area in segment.get_node("Area2D").get_overlapping_areas():
#				print(area, area.get_parent() , area.get_parent().get_parent())
				if area.get_parent() is Road:
					has_crossing = true
					break
		if !has_crossing:
			var segment_num = randi_range(0, len(river.get_children())-1)
			var new_bridge_position = $"../..".to_global(river.get_child(segment_num).get_node("Area2D").global_position)
#			var segment = river.get_child(segment_num)
#			var collision_shape = segment.get_node("Area2D/CollisionShape2D").shape 
			var top_edge = river.segment_edges[segment_num][0]#segment.global_position + Vector2(collision_shape.extents.x, -collision_shape.extents.y)
			var bottom_edge =river.segment_edges[segment_num][1] # segment.global_position + Vector2(collision_shape.extents.x, collision_shape.extents.y)
			var angle_degrees = (top_edge - bottom_edge).angle() * 180 / PI #+ 45 
			var bridge_instance = bridge_scene.instantiate() as Sprite2D
			bridge_instance.rotation_degrees = angle_degrees
			bridge_instance.position = new_bridge_position
			root.get_node("Structures").add_child(bridge_instance)
 

func instantiate_roads(start, end):
	var road_instance = road_scene.instantiate() as Node2D
	var collision_area = road_instance.get_node("Area2D")
#	print(start, end)
	collision_area.position = Vector2(start + end ) / 2
	collision_area.rotation = start.direction_to(end).angle()
	var length = start.distance_to(end)
	var rect = RectangleShape2D.new()
	var collision_shape = collision_area.get_node("CollisionShape2D")
	rect.extents = Vector2(length / 2, 8)
	collision_shape.shape = rect
	road_instance.get_node("Line2D").add_point(  end )
	road_instance.get_node("Line2D").add_point(  start )
	root.get_node("Structures").add_child(road_instance)

 


 
#func put_unit_into_teams():
#	var units = get_tree().get_nodes_in_group("living_units") 
#	for i in range(len(units)):
#		var unit = units[i]
#		var team = Globals.teams[i % len(Globals.teams)]
#		unit.add_to_team(team)
#		unit.is_newly_bought = false
#	Globals.placed_unit = null
#
#
