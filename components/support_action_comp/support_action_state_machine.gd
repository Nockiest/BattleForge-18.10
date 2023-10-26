extends StateMachine

 


func _ready() -> void:
	await owner._ready()
	# The state machine assigns itself to the State objects' state_machine property.
	for child in get_children():
		child.state_machine = self
		child.SupportActionNode = get_parent()
	state.enter()

func _process(delta: float) -> void:
#	if Input.is_action_just_pressed("right_click"):
	
#	if "color" in owner:
#	if Color(Globals.cur_player) != get_parent().owner.color:
#		return
#	else:
	state.update(delta)
		
func provide_buffs():
	if state == $ProvidingSupport and  $ProvidingSupport .supported_entity != null:
		state.provide_buffs()
