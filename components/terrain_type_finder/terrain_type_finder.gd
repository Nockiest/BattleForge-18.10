class_name TerrainTypeFinder
extends Node2D

var overlapping_terrain_type:String = "pasture"
@export var bodies_masks_for_detection:Array[int] = [2,4,5,8,9]


func _ready() -> void:
	for index in bodies_masks_for_detection:
#		print(index)
		$Area2D.set_collision_mask_value(index , true)
func _process(_delta: float) -> void:
	queue_redraw()
func _draw():
	draw_circle(Vector2.ZERO, 2, Color("white"))
func find_current_overlapping_terrain():
	# Set the point in 2D space where you want to check for overlapping areas
	var new_overlap = "pasture"
#	global_position = get_global_mouse_position()
 
	for area in $Area2D.get_overlapping_areas():
#		for shape in area.get_overlapping_areas():
		if area.get_parent() is RiverSegment   and new_overlap != "road" :
			print("AREA IS OVERLAPPING", area.get_parent())
			new_overlap = "river"
			break
		elif area is Town   and(new_overlap != "road" or   new_overlap != "river"):
			print("AREA IS OVERLAPPING", area.get_parent())
			new_overlap = "town"
		elif area.get_parent() is Road or  area.get_parent() is Bridge:
			new_overlap = "road"
	for area in get_tree().get_nodes_in_group("forrest_shape")  :  # Replace with your group name
#		if area.get_parent().is_point_in_polygon ( point_in_space, area.get_parent() ):
		if Utils.calculate_is_inside(area.get_parent(), global_position)and (new_overlap != "road"and new_overlap != "river"):
			print("Point is inside Area2D:", area,  ) 
			new_overlap = "forest"	
	overlapping_terrain_type = new_overlap
	# Get an array of Area2D nodes overlapping the specified point
#	for area in get_tree().get_nodes_in_group("river_segment_collision_shapes"):  # Replace with your group name
#		for shape in area.get_overlapping_areas():
#			if shape == $Area2D:
#				print("OVERLAPPING AREA")
#			print("Point is inside Area2D:", area,)  # Adjust the properties you want to print
#	for area in get_tree().get_nodes_in_group("towns"):  # Replace with your group name
#		#if  Utils.is_point_inside_rect(area,  area.get_shape().extents, global_position) :
#		if Utils.calculate_is_inside(area.get_node("Polygon2D"), global_position):
#			print("Point is inside Area2D:", area, )  # Adjust the properties you want to print
#			overlapping_terrain_type = "town"
#func _on_area_2d_area_exited(area: Area2D) -> void:
#	print("ENTERED AREA ", area)
		## get the position of all the edges
		## create a polygon out of it
		## check wheter a pooint is inside this polygon
#		var area_rotation = area.get_rotation_degrees() 
#
#		var polygon = Utils.square_to_packed_polygon(area.get_node("CollisionShape2D"))
##		print(area_rotation," ",   " ROTATE", polygon)
#		polygon.rotation = area_rotation
##		print(Utils.calculate_is_inside(polygon , global_position))
#		if Utils.calculate_is_inside(polygon , global_position) :#Utils.is_point_inside_rect(area,  area.get_node("CollisionShape2D").shape.extents*2, global_position):
##		if area is Area2D and area.is_point_inside(point_in_space):
#			print("Point is inside Area2D:", area,  )  # Adjust the properties you want to print
#			overlapping_terrain_type = "river" 
#	 
