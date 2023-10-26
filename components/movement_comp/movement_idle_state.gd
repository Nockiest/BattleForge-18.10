extends MovementState


 

func update(_delta:float):
	if Input.is_action_just_pressed("left_click"):
		state_machine.transition_to("Moving") 

func enter(msg={}):
	$"../../terrain_type_finder".find_current_overlapping_terrain()
	MoveComp.owner.current_terrain = $"../../terrain_type_finder".top_most_terrain_type

