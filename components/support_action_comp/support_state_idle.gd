class_name SupportStateIdle
extends SupportState
 

func update(_delta:float):
	if Input.is_action_just_pressed("right_click") and  $"../..".owner == Globals.hovered_unit :
		state_machine.transition_to("ChoosingSupport")

func enter(_msg:={}):
	SupportActionNode.get_node("AttackRangeCircle").hide()
