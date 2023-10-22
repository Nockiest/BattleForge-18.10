class_name  River
extends Node2D
##most logic currently handled in the Battleround component
var river_segment_scene:PackedScene = preload("res://structures/river_segment.tscn")
var screen_size:Vector2 
var start_point:Vector2 #= Vector2(randi_range(0, screen_size.x / 2), randi_range(0, screen_size.y / 2))
# Generate a random end point on the right or bottom side of the screen
var end_point:Vector2 # = Vector2(randi_range(screen_size.x / 2, screen_size.x), randi_range(screen_size.y / 2, screen_size.y))
var control_point:Vector2 #  =  Vector2(randi_range(100, screen_size.x-100), randi_range(100, screen_size.y-100))
var num_segments = 10
var itersecting_point_index:int
var segment_edges:Array = []
 

func add_river_segment(segment_start, segment_end):
	var river_segment_instance = river_segment_scene.instantiate() as Node2D
	river_segment_instance.connect("intersects_another_river", set_river_intersection)
	
	var collision_area = river_segment_instance.get_node("Area2D")
	collision_area.position = (segment_start + segment_end) / 2
	collision_area.rotation = segment_start.direction_to(segment_end).angle()
	
	var length = segment_start.distance_to(segment_end)
	var extra_space = 10.0  # Adjust this value to determine the extra space around the river segment
	
	# Augment the size of the rectangle shape
	var rect = RectangleShape2D.new()
	rect.extents.x = length / 2 + extra_space
	rect.extents.y = 4  # You need to define the original size or obtain it dynamically
	
	var collision_shape = collision_area.get_node("CollisionShape2D")
	collision_shape.shape = rect
	var enlarged_area = river_segment_instance.get_node("EnlargedColArea")
	enlarged_area.position = (segment_start + segment_end) / 2
	enlarged_area.rotation = segment_start.direction_to(segment_end).angle()

	var polygon =  Polygon2D.new()
	
## I HAVE DELETED THE COLLISION SHAPE FOR THE ENLARGED AREA
#	var enlarged_collision_shape = enlarged_area.get_node("CollisionShape2D")
#	enlarged_collision_shape.shape = polygon

	var points = PackedVector2Array([
		Vector2(-length / 2, -50),
		Vector2(length / 2, -50),
		Vector2(length / 2, 50),
		Vector2(-length / 2, 50)
	])
	polygon.set_polygon(points)
	polygon.hide()
	enlarged_area.add_child(polygon)
	polygon.add_to_group("enlarged_river_collision_areas")
	river_segment_instance.get_node("Line2D").add_point(  segment_end )
	river_segment_instance.get_node("Line2D").add_point( segment_start )
	segment_edges.append([segment_start, segment_end]) ## used for bridge angle calculation
 
	call_deferred("add_child_to_segments", river_segment_instance)
 
func add_child_to_segments(child):
	add_child(child)
func set_river_intersection(segment,colliding_area):
 
	itersecting_point_index = segment.get_index( )
	solve_river_intersection(segment,colliding_area)
#	print(itersecting_point_index, self)
 

func solve_river_intersection(segment,colliding_area ):
 
	if itersecting_point_index == null:
		return
	if not( get_index() < get_parent().get_child_count() - 1):
		return

#	print("SOLVING", itersecting_point_index, $segments.get_children())
#	if placment_completed:
#		return
	for node in $segments.get_children():
#		print(node,  node.get_index() , itersecting_point_index)
	# Check if the node has a higher index than the segment in the argument
		if node.get_index() >= itersecting_point_index:
	# Remove the node from the scene tree
			node.queue_free()
	var new_segment_start = segment.get_node("Line2D").points[0]
	var new_segment_end = colliding_area.get_parent().get_node("Line2D").points[1]
	add_river_segment(new_segment_start, new_segment_end )
#	# Add the Line2D node to the scene tree
 
 
