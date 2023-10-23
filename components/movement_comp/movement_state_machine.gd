extends StateMachine


func _ready() -> void:
	await owner._ready()
	# The state machine assigns itself to the State objects' state_machine property.
	for child in get_children():
		child.state_machine = self
		child.MoveComp = get_parent()
	
	if get_parent().owner == Globals.placed_unit:
		state = $Placement
	state.enter()

func _process(delta: float) -> void:
	if Color(Globals.cur_player) == get_parent().owner.color:
		state.update(delta)
