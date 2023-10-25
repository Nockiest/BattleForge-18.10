extends ActionState

func enter(_msg = {}):
	AttackComponent.get_node("AttackRangeCircle").hide()


 
func update(_delta: float) -> void: 
	if  Input.is_action_just_pressed("right_click"):
		print(Globals.action_taking_unit , AttackComponent.owner)
	if Input.is_action_just_pressed("right_click") and Globals.moving_unit== null and Globals.action_taking_unit == null:
		state_machine.transition_to("Active")
		
