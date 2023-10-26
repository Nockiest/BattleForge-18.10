# toggle_action_screen()
#func play_attack_animation(attacked_entity):
#	$SlashAnimation.z_index = 1000
#	#	slash_animation.position = Globals.hovered_unit.position #.ZERO  # Center of the unit
#	var collision_shape = attacked_entity.get_node("CollisionArea/CollisionShape2D")  # Replace with your actual node path
#	var shape_size = collision_shape.shape.extents * 2  # For RectangleShape2D and CapsuleShape2D
#	$SlashAnimation.global_position = Globals.hovered_unit.global_position + shape_size / 2
#	# Calculate the angle to face Globals.hovered_unit
#	if Globals.hovered_unit:
#		var dir_to_hovered = (Globals.hovered_unit.position - position).normalized()
#		var angle_to_hovered = dir_to_hovered.angle()
#		$SlashAnimation.rotation = angle_to_hovered
#
#	$SlashAnimation.play("slash")

#	Engine.time_scale = 0.5


# The unit's collision shape is overlapping with the ResupplyAction's collision shape
			# Provide buffs here
#	super.provide_buffs()
#	if supported_entity:
#		Utils.play_animation_at_position($AnimatedSprite2D,"resupply_animation", supported_entity.global_position) 
 
#	var shape = RectangleShape2D.new()
#	shape.extents = Vector2(48, 48)
##	$CollisionShape2D.shape = shape

#	var same_color_units = []
#	for unit in units:
#		if unit.color != Color(team):
#			continue
#		same_color_units.append(unit)

# scale = Vector2(test_scale,test_scale )

#	var tenders = get_tree().get_nodes_in_group("player_tenders") 
#	for i in range(len(tenders)):
#		var tender = tenders[i]
#		if tender.team == "blue":
##			print(tender.team, tender.money, tender.units) 
#			tender.money-= cost

#	for unit in same_color_units:
#		var unit_type = unit.unit_name  # get_class()
#		if unit_type in sorted_units:
#			sorted_units[unit_type] += 1
#		else:
#			sorted_units[unit_type] = 1

	# Get all the grandchildren of the VBoxContainer
	
	#var unit_types = ["cannon", "pikeman", "shield", "medic", "knight", "musketeer"]
#var unit_images = [preload("res://img/cannon.png"), preload("res://img/pikeman.png"), preload("res://img/shield.png"), preload("res://img/medic.png"), preload("res://img/knight.png"), preload("res://img/musketeer.png")]

#func _process(delta):
#	queue_redraw() 
 
#	if not Globals.hovered_unit or Globals.hovered_unit.color == get_parent().color:
#		attack_failed.emit()
#		return "failed"	
#	print( self.get_parent().global_position.distance_to(Globals.hovered_unit.global_position), action_range)
#	var distance = self.get_parent().global_position.distance_to(Globals.hovered_unit.global_position) 
#	if distance > action_range:
#		attack_failed.emit()
#		return "failed"

#func play_attack_animation(attacked_entity):
#	$SlashAnimation.z_index = 1000
#	#	slash_animation.position = Globals.hovered_unit.position #.ZERO  # Center of the unit
#	var collision_shape = attacked_entity.get_node("CollisionArea/CollisionShape2D")  # Replace with your actual node path
#	var shape_size = collision_shape.shape.extents * 2  # For RectangleShape2D and CapsuleShape2D
#	$SlashAnimation.global_position = Globals.hovered_unit.global_position + shape_size / 2
#	# Calculate the angle to face Globals.hovered_unit
#	if Globals.hovered_unit:
#		var dir_to_hovered = (Globals.hovered_unit.position - position).normalized()
#		var angle_to_hovered = dir_to_hovered.angle()
#		$SlashAnimation.rotation = angle_to_hovered
#
#	$SlashAnimation.play("slash")

#
#func _on_attack_range_area_area_entered(area):
##	print (area.get_parent()," ",  area.get_parent() == self, " ", Globals.action_taking_unit != self, " ", self)
#	if area.get_parent() == self:
#		return
#	if Globals.action_taking_unit != self:
#		return
#	if area.name == "CollisionArea" and area.get_parent() is BattleUnit and not units_in_action_range.has(area):
#		units_in_action_range.append(area.get_parent())
##	print("THESE ARE UNITS IN RANGE NOW", units_in_action_range)
#func _on_attack_range_area_area_exited(area):
#	if area.get_parent() == self:
#		return
#	if Globals.action_taking_unit!= self:
#		return
#	if area.name == "CollisionArea" and units_in_action_range.has(area.get_parent()):
#		units_in_action_range.erase(area.get_parent()) 

 
#    def try_attack(self, click_pos, attacked_unit):
#        ####!!!RANGED UNITS ARNET CONNECTED O THIS FUNCTION!!!#####
#        if attacked_unit in self.enemies_in_range:
#            self.try_attack()
#            hit_result = attacked_unit.check_if_hit()  # 80% hit chance
#            # num_attacks += 1
#            if hit_result:
#                remaining_hp = attacked_unit.take_damage(self)
#                print("remaining enemy hp", remaining_hp)
#
#                return "UNIT ATTACKS"
#            else:
#                return "UNIT MISSED"
#        return "Attack not possible"

#    def get_attackable_units(self):
#        self.enemies_in_range = []
#        self.lines_to_enemies_in_range = []
#        total_attack_range_modifier = sum(self.aciton_range_modifiers.values())
#        # for every living unit
#        for enemy in game_state.living_units.array:
#            if enemy.color == self.color:
#                continue
#            center_x, center_y = self.center
#            enemy_center_x, enemy_center_y = enemy.center
#            distance = math.sqrt((enemy_center_x - center_x)
#                                 ** 2 + (enemy_center_y - center_y)**2)
#            line_points = bresenham_line(
#                center_x, center_y, enemy_center_x, enemy_center_y)
#            if distance - enemy.size//2 < self.action_range  * total_attack_range_modifier:
#                blocked = self.find_obstacles_in_line_to_enemies(
#                    enemy, line_points)
#
#                if not blocked:
#                    self.enemies_in_range.append(enemy)
#
#        print("in try_attack range are", self.enemies_in_range)
#
#	generate_bezier_curve(mid_point, end_point, num_segments)
	
#	for i in line.points.size() - 1:
#		print("child", $segments.get_child(i))
	## for creating collision shape for the line
#	for i in line.points.size() - 1:
#		var new_shape = CollisionShape2D.new()
#		add_child(new_shape)
#		var rect = RectangleShape2D.new()
#		new_shape.position = (line.points[i] + line.points[i + 1]) / 2
#		new_shape.rotation = line.points[i].direction_to(line.points[i + 1]).angle()
#		var length = line.points[i].distance_to(line.points[i + 1])
#		rect.extents = Vector2(length / 2, 10)
#		new_shape.shape = rect
 
	
#	for segment in enlarged_areas:
##		var enlarged_area = segment.get_node("EnlargedColArea")
##		var polygon = enlarged_area.get_child_by_type(Polygon2D)
#		print(Utils.calculate_is_inside(segment))
#	var Geometry = Geometry2D.new()
#	Geometry.is_point_bin_polygon()
#	var enlarged_river_segments = []
#
#	for segment in river_segments:
#		print("RIVER SEGMENT")
#		var area_2d = segment.get_node("Area2D/CollisionShape2D")
#		var shape = area_2d.shape
#		var new_extents = shape.extents + Vector2(50, 50)
#		shape.extents = new_extents
#		enlarged_river_segments.append(area_2d)
#	print("ENLARGED",enlarged_river_segments, )



#	match current_state:
#		current_state.no_support_connection :
#			print("NOT PROVIDING SUPPORT CONNECTION")
#		current_state.new_support_connection :
#			print("CREATED NEW SUPPORT CONNECTION")
#		current_state.support_already_provided:
#			print("ALREADY PROVIDED SUPPORT")

#
#func place_bridges_over_road_river_crosssing():
#	for road in get_tree().get_nodes_in_group("roads"):
##		print(road.get_node("Line2D"))
##		print(road.get_node("Area2D").get_overlapping_areas())
#		for area in road.get_node("Area2D").get_overlapping_areas():
#			if area.get_parent() is RiverSegment and not (area is EnlargedColArea):
#				print("CROSSING A RIVER SEGMENT ", area.get_parent() )
##				var road_dir = road.get_node("Line2D").get_normal()
##				var river_dir = area.get_parent().get_direction()
#				var road_start = road.get_node("Line2D").get_point_position(0)
#				var road_end = road.get_node("Line2D").get_point_position(1)
#				var angle_degrees = (road_start - road_end).angle() * 180 / PI
#				# Calculate the angle between the two vectors
##				var angle = road_dir.angle_to(river_dir)* 180 / PI 	 
#				var index =  area.get_parent() .get_index()#.get_parent().get_child_index( area.get_parent())
#				var top_edge = area.get_parent().get_parent().segment_edges[index][0]#segment.global_position + Vector2(collision_shape.extents.x, -collision_shape.extents.y)
#				var bottom_edge =area.get_parent().get_parent().segment_edges[index][1]
#				var interscetion_point = Utils.do_lines_intersect_in_viewport(road_start, road_end, top_edge, bottom_edge)
#				print(road_start, road_end, top_edge, bottom_edge, interscetion_point)
#				if interscetion_point:
#					var bridge_instance = bridge_scene.instantiate() as Sprite2D
#					bridge_instance.rotation_degrees = angle_degrees
#					bridge_instance.global_position = interscetion_point
#					$Structures.add_child(bridge_instance)
##				print("CROSSING A RIVER SEGMENT ", area.get_parent(), "Angle: ", angle)
#

#!!!!!USEFUL CODE print(is_inside_tree())

## logarithm
#	var linear_slider_value : float = value
#	# Assuming your slider value ranges from 0 to 1
#	var min_slider_value : float = 0.0
#	var max_slider_value : float = 1.0
#
#	# Assuming your desired volume range in decibels
#	var min_volume_db : float = -80.0
#	var max_volume_db : float = 0.0
#
#	# Convert linear slider value to logarithmic scale
#	var log_slider_value : float = min_slider_value + (max_slider_value - min_slider_value) * linear_slider_value
#	var log_volume_db : float = min_volume_db + (max_volume_db - min_volume_db) * exp(log_slider_value)
#
#	# Set the volume
#	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), log_volume_db)
