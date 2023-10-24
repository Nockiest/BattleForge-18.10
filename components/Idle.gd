extends ActionState

func enter(_msg = {}):
	AttackComponent.get_node("AttackRangeCircle").hide()


 
func update(_delta: float) -> void: 
	if Input.is_action_just_pressed("right_click") and Globals.moving_unit== null:
		print("ACTIVATING")
		state_machine.transition_to("Active")
		
