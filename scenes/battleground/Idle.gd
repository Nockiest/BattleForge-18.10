extends BattlegroundState


func update(_delta):
	$"../../VBoxContainer/DebugLabel".text = str($"../../".get_global_mouse_position())
	$"../../VBoxContainer/HoveredUnit".text = str(Globals.hovered_unit)
	$"../../VBoxContainer/ActionTakingUnit".text = str(Globals.action_taking_unit)
