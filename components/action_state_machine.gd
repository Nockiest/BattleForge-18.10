class_name ActionCompStateMachine
extends StateMachine


 
func _ready() -> void:
	await owner._ready()
	# The state machine assigns itself to the State objects' state_machine property.
	for child in get_children():
		child.state_machine = self
		child.AttackComponent = get_parent()
	state.enter()
func _process(delta: float) -> void:
	if "color" in owner:
			if Color(Globals.cur_player) != owner.color:
				return
	else:
		state.update(delta)
