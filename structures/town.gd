class_name Town
extends Area2D
var house_scene:PackedScene = preload("res://structures/house.tscn")  # get the house.tscn
var num_houses:int = 5
@onready var rect_shape =  $CollisionShape2D.shape as RectangleShape2D  # Access the RectangleShape2D
# Called when the node enters the scene tree for the first time.
var units_inside: Array
var team_alligiance 
var connected_roads:int = 0
var connected_towns: Array = []
var outline_node


func _process(_delta):
#	if Globals.placed_unit and team_alligiance and Globals.placed_unit.is_inside_tree():
#		print(Globals.placed_unit.color ,Color(team_alligiance))
	if  Globals.placed_unit == null or  team_alligiance == null:
		$ColorRect.modulate = Color("#826700") 
	elif Globals.placed_unit.color == Color(team_alligiance):
		print("MODULATE COLOR RECT ", team_alligiance)
		if team_alligiance == "blue":
			
			$ColorRect.modulate = Color(1, 1, 1) # Light blue
		else:
			$ColorRect.modulate = Globals.placed_unit.color
 
	## make sure that collision shape in house scene is stil on index 0 otherwise it wont work


func place_house():
	for house in range(num_houses):
		var house_instance = house_scene.instantiate() as Area2D
		instantiate_a_house(house_instance)
		add_child(house_instance)
		house_instance.connect("house_interferes", instantiate_a_house ) 


func instantiate_a_house(house):
	var placement_positions = []
	var tries = 0
	var max_tries = 1000
	var valid_position =false
	var random_x
	var random_y
	var house_collision_shape = house.get_child(0).shape as RectangleShape2D  # Access the house's RectangleShape2D
	var min_x = house_collision_shape.extents.x  
	var max_x = (rect_shape.extents.x - min_x)*2
	var min_y = house_collision_shape.extents.y  
	var max_y = (rect_shape.extents.y - min_y)*2
  
	while !valid_position and tries < max_tries:
#		var new_point = Utils.get_random_point_in_square(placment_area.get_node("CollisionShape2D").shape.extents*2)
		random_x = randi_range(min_x, max_x)
		random_y = randi_range(min_y, max_y)
		valid_position = true
		var river_segments_shapes = get_tree().get_nodes_in_group("river_segment_collision_shapes")
		for segment in river_segments_shapes:
			if not Utils.are_points_far_enough( to_global( Vector2(random_x, random_y)), Utils.get_collision_shape_center(segment), 25):
				valid_position = false
				break
		tries += 1
 
	if tries >max_tries:
		return
 
 
 
	house.position = Vector2(random_x, random_y)
	

func is_area_occupied(area):
	for child in $Houses.get_children():
		print_debug(child is Area2D ,child != area ,child.intersects_area(area))
		if child is Area2D and child != area and child.intersects_area(area):
			return true
	return false
 
 
func _on_area_entered(area): 
	if not(area is UnitsMainCollisionArea):
		return
	if not (area.get_parent() is BattleUnit):
		return
#	print("UNIT ENTERED TOWN ",  area.get_parent())
	units_inside.append(area.get_parent())
 
func _ready():
	if not is_far_enough():
		free()
		return
	place_house()
	outline_node = Utils.polygon_to_line2d($Polygon2D, 2)
	outline_node.z_index = 20
	add_child(outline_node)
#	check_overlaps_other_towns()

func is_far_enough():
	for town in get_tree().get_nodes_in_group("towns"):
		if town == self:
			continue
		if Utils.get_collision_shape_center(self  ).distance_to(Utils.get_collision_shape_center(town  ) ) <  Globals.min_town_spacing_distance:
			return false
	return true

func _on_area_exited(area):
 
#	if not (area is UnitsMainCollisionArea):
#		return
#	if area.get_parent() not in units_inside:
#		return
#	print("UNIT EXITED TOWN ",  area.get_parent(), area,  units_inside )
	if area.get_parent() in units_inside:
		units_inside.erase(area.get_parent())
		
func make_next_turn_calculations():
	check_who_occupied()
	change_edge_color()

func check_who_occupied():
	var blue_count = 0
	var red_count = 0
	team_alligiance = null
	for unit in units_inside:
		if unit.color == Color("red"):
			red_count += 1
		elif unit.color == Color("blue"):
			blue_count += 1
		else:
			print("I DONT NOW THIS TEAM", unit.color)
	if blue_count > red_count:
		team_alligiance = "blue"
	elif red_count > blue_count:
		team_alligiance = "red"
	
 
func change_edge_color():
	if team_alligiance == "blue":
		outline_node.modulate = Color("blue")
	elif team_alligiance == "red":
		outline_node.modulate = Color("red")	
	else:
		outline_node.modulate = Color("white")
		
func connect_to_other_towns():
	var towns = get_tree().get_nodes_in_group("towns")
	var town_distances = [] ##array of arrays with the distance and the town
	for town in towns:
		if town == self:
			continue
		if town.connected_roads > 2:
			continue
#			print(town, " HAS TO MANY ROADS LEADING TO IT")
		town_distances.append([ position.distance_to(town.position), town])
		town_distances.sort()
	for i in range(min(2, len(town_distances))):
		town_distances[i][1].connected_roads += 1
		connected_towns.append(town_distances[i][1])
		connected_roads += 1
 
		
			
		
