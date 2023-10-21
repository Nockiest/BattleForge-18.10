extends SupportState


func update(delta:float):
	if Input.is_action_just_pressed("right_click") and  $"../..".owner == Globals.hovered_unit :
		state_machine.transition_to("ChoosingSupport")

func enter(msg:={}):
	SupportActionNode.get_node("AttackRangeCircle").hide()
