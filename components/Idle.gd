extends ActionState

func enter(_msg = {}):
	AttackComponent.get_node("AttackRangeCircle").hide()
	print(AttackComponent.get_node("BlastAnimation") , AttackComponent.position)
	if AttackComponent.get_node("BlastAnimation"):
		
		AttackComponent.get_node("BlastAnimation").position = AttackComponent.position

 
func update(_delta: float) -> void: 
	if  Input.is_action_just_pressed("right_click"):
		print(Globals.action_taking_unit , AttackComponent.owner)
	if Input.is_action_just_pressed("right_click") and Globals.moving_unit== null and Globals.action_taking_unit == null:
		state_machine.transition_to("Active")
		
