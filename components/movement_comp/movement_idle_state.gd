extends MovementState


 

func update(_delta:float):
	if Input.is_action_just_pressed("left_click"):
		state_machine.transition_to("Moving") 
