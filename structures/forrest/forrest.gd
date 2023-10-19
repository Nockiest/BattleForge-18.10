class_name Forrest
extends Node2D

var forrest_scene_number =  randi_range(1, 3) 
var forrest_shape_1 =  preload("res://structures/forrest/forrest_shape_1.tscn")
var forrest_shape_2 =  preload("res://structures/forrest/forrest_shape_2.tscn")
var forrest_shape_3 =  preload("res://structures/forrest/forrest_shape_3.tscn")
func _ready():
	var forrest_shape_instance  
	match forrest_scene_number:
		1:
			forrest_shape_instance = forrest_shape_1.instantiate() as Polygon2D
		2:
			forrest_shape_instance = forrest_shape_2.instantiate() as Polygon2D
		3:
			forrest_shape_instance = forrest_shape_3.instantiate() as Polygon2D
		_:
			print("NOTHING MATCHED, running default instance",forrest_scene_number)
			forrest_shape_instance = forrest_shape_1.instantiate() as Polygon2D
#	forrest_shape_instance.collision_layer = 8
	add_child(forrest_shape_instance)
	position = Vector2(randi_range(50, get_viewport().size.x-50) ,randi_range(50, get_viewport().size.y-50))
	scale = Vector2( randf_range(0.5,1.2), randf_range(0.5,1.2) )
#	get_node("Polygon2D").modulate = Color("green")
	get_node("forrest_shape").color = Color("#228b22")
	var outline = Utils.polygon_to_line2d(forrest_shape_instance, 2, Color("black"))
	add_child(outline)
 
