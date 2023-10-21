extends StateMachine

 


func _ready() -> void:
	await owner._ready()
	# The state machine assigns itself to the State objects' state_machine property.
	for child in get_children():
		child.state_machine = self
		child.SupportActionNode = get_parent()
	state.enter()
