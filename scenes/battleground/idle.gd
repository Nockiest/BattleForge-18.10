extends BattlegroundState

var beginning_of_the_game = false

func enter(_msg = {}):
	if !beginning_of_the_game:
		$"../../StartGame".play()
		beginning_of_the_game = true
	else:
		$"../../NextTurn".play()
func update(_delta):
	$"../../VBoxContainer/DebugLabel".text = str($"../../".get_global_mouse_position())
	$"../../VBoxContainer/HoveredUnit".text = str(Globals.hovered_unit)
	$"../../VBoxContainer/ActionTakingUnit".text = str(Globals.action_taking_unit)
