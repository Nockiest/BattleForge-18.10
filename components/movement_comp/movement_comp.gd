class_name MovementComponent
extends Node2D
 
signal hit_river()
var base_movement_range:int:
	set(new_range):
		base_movement_range = new_range *1.5
		remain_distance = base_movement_range  
@onready var global_start_turn_position 
 
var remain_distance  = base_movement_range:
	set(new_distance):
		remain_distance = max(new_distance, 0) 
	get:
		return remain_distance
 
var current_movement_modifier:float = 1.0   
 
func _ready():
	await owner._ready()
	global_start_turn_position = owner.center
 
func translate_terrain_to_move_modifier() -> float:
	$"terrain_type_finder".find_current_overlapping_terrain()
	match $"terrain_type_finder".top_most_terrain_type:
		"river":
			hit_river.emit()
			return 10000
		"pasture":
			return 1 
		"road":
			return 0.5 
		"town":
			return 0.75 
		"forest":
			return 1.5
	print("THERE IS A PROBLEM IN THE TRANSLATE TO MOVE MODIFIER FC ", $"terrain_type_finder".top_most_terrain_type)
	return 10000
 
 
func process_for_next_turn():
	remain_distance = base_movement_range
	set_new_start_turn_point()  

func set_owner_position(new_position):
	if Globals.moving_unit != get_parent():
		print("CANT SET TO ", new_position)
		return
#	print("SETTING POSITION ", new_position)
	owner.global_position = new_position
	owner.center = owner.get_node("Center").global_position

func  set_new_start_turn_point():
#	print("SETTING NEW START TURN POS", global_position)
	global_start_turn_position = global_position
 


