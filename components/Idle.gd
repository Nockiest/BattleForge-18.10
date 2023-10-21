extends ActionState

func enter(msg = {}):
	AttackComponent.get_node("AttackRangeCircle").hide()


 
func update(delta: float) -> void: 
	if Input.is_action_just_pressed("right_click"):
		state_machine.transition_to("Active")
		
