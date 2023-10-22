extends MovementState
class_name MovementMovingState
 
var mouse_pos_offset:Vector2
var exiting_moving_state = false
func enter(_msg=[]):
	if not check_can_turn_movement_on():
		state_machine.transition_to("Idle") 
		return 
	exiting_moving_state = false
#	MoveComp.calculate_total_movement_modifier() 
	Globals.moving_unit = MoveComp.owner
	Globals.action_taking_unit = null
	print("TURNING MOVEMENT LOOK ON")
	var mouse_pos = MoveComp.get_global_mouse_position()
	var x_distance = mouse_pos.x - MoveComp.owner.global_position.x
	var y_distance = mouse_pos.y - MoveComp.owner.global_position.y
	mouse_pos_offset = Vector2(x_distance, y_distance) 
	toggle_moving_appearance("on")
	MoveComp.get_node("SelectSound").play()
	MoveComp.get_node("MovementSound").play()
 
func update(_delta: float):
#	$"../../terrain_type_finder".find_current_overlapping_terrain()
	MoveComp.current_movement_modifier = MoveComp.translate_terrain_to_move_modifier() 
#	match MoveComp.get_node("terrain_type_finder").overlapping_terrain_type:
#		"river":
#			abort_movement()
#		"pasture":
#			MoveComp.current_movement_modifier = 1
#		"road":
#			MoveComp.current_movement_modifier = 0.5
#		"town":
#			MoveComp.current_movement_modifier = 0.75 
	if Input.is_action_just_pressed("right_click"):
		abort_movement()
	elif Input.is_action_just_pressed("left_click"):
		state_machine.transition_to("Idle") 
	elif !exiting_moving_state:
		move() 
		
	
 
func exit():
	toggle_moving_appearance("off")
	MoveComp.get_node("SelectSound").stop()
	MoveComp.get_node("MovementSound").stop()
	if Globals.moving_unit == MoveComp.owner:
		Globals.moving_unit = null


func toggle_moving_appearance(toggle):
	if toggle == "on":
		MoveComp.owner.outline_node.modulate = Color("black")
		MoveComp.owner.get_node("ColorRect").modulate = Color(0.5,0.5,0.5,0.25)
	elif toggle == "off":
		MoveComp.owner.outline_node.modulate = Color("white")
		MoveComp.owner.get_node("ColorRect").modulate = Color(MoveComp.owner.color)
	else:
		print("ARGUMENT ", toggle)
		assert(false, "TOGGLE MOVEMENT COLOR GOT BAD ARGUMENT" )


 
func check_can_turn_movement_on():
	if Globals.hovered_unit != MoveComp.owner:
#		print("CASE 2")
		return false
	elif Globals.action_taking_unit !=   MoveComp.owner and Globals.action_taking_unit != null:
#		print("CASE 3")
		return false
	elif Globals.action_taking_unit != null:
#		print("CASE 4")
		return false
	elif Globals.placed_unit != null:
#		print("case 5")
		return false
	return true


func _on_movement_comp_hit_river() -> void:
	abort_movement()
func move( ):
	if Globals.moving_unit != MoveComp.owner:
		return
	## distance just traveled is the distanc ebetween current center and the mousepos with accounted offset that gives the current center
	var mouse_pos = MoveComp.get_global_mouse_position() 
	var new_position =  mouse_pos  - mouse_pos_offset  
	var old_position = MoveComp.owner.global_position
	var distance_just_traveled = floor( new_position.distance_to(old_position) ) * MoveComp.current_movement_modifier  
#	print( new_position.distance_to(old_position) , "DISTANCE",mouse_pos_offset,  new_position,   old_position)
	MoveComp.remain_distance -= distance_just_traveled
	if MoveComp.remain_distance < 0:
		return
	MoveComp.set_owner_position(new_position)
 
func abort_movement():
	exiting_moving_state = true
	print("CALLED ABORT MOVEMENT ",  MoveComp.global_start_turn_position)
	Globals.moving_unit = null
	MoveComp.set_owner_position( MoveComp.global_start_turn_position-MoveComp.owner.size/2)  
	state_machine.transition_to("Idle")
	MoveComp.remain_distance =  MoveComp.base_movement_range
	print("OWNER POSITION AFTER ABORT",MoveComp.owner.global_position)
## A very ugly way to deceslect movement
 

 
