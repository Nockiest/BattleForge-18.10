extends ActionState


 
func _process(delta: float) -> void:
	if Globals.hovered_unit != AttackComponent.owner:
		state_machine.transi
