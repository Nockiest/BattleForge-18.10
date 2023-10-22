class_name MovementComponent
extends Node2D
#signal remain_movement_changed( )
signal ran_out_of_movement()
signal hit_river()
var base_movement_range:int:
	set(new_range):
		base_movement_range = new_range *3
		remain_distance = base_movement_range  
@onready var global_start_turn_position 
 
var remain_distance  = base_movement_range:
	set(new_distance):
		remain_distance =new_distance 
		if new_distance < 0 :
			ran_out_of_movement.emit()#abort_movement()
			remain_distance =  base_movement_range
			owner.update_stats_bar()
	get:
		return remain_distance
#var movement_modifiers:Dictionary = {
#	"base_modifier": 1,
#	"on_road": 0,
#	"in_forrest": 0,
#	"in_town": 0, 
#} 
var current_movement_modifier:float = 1.0   
#var on_bridge:= false 
#var on_river:= false
 
func _ready():
	await owner._ready()
#	$"terrain_type_finder".find_current_overlapping_terrain()
#	current_movement_modifier= call_deferred_thread_group("translate_terrain_to_move_modifier") 
#	call_deferred_thread_group("calculate_total_movement_modifier")
	global_start_turn_position = owner.center

func translate_terrain_to_move_modifier() -> float:
	$"terrain_type_finder".find_current_overlapping_terrain()
	match $"terrain_type_finder".overlapping_terrain_type:
		"river":
			hit_river.emit()
			return 10000
		"pasture":
			return 1 
		"road":
			return 0.5 
		"town":
			return 0.75 
	print("THERE IS A PROBLEM IN THE TRANSLATE TO MOVE MODIFIER FC ", $"../../terrain_type_finder".overlapping_terrain_type)
	return 10000
 
 
func process_for_next_turn():
	remain_distance = base_movement_range
	set_new_start_turn_point()  

func set_owner_position(new_position):
	if  remain_distance == base_movement_range:
		print("CANT CHANGE THE POSITION")
		return
	owner.global_position = new_position
	owner.center = owner.get_node("Center").global_position

func  set_new_start_turn_point():
	print("SETTING NEW START TURN POS", global_position)
	global_start_turn_position = global_position
 


