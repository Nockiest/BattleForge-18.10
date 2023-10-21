extends SupportState


func update(delta:float):
	if Input.is_action_just_pressed("right_click"):
		state_machine.transition_to("ChoosingSupport")
