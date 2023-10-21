class_name ObserveStateProviding
extends   SupportStateProviding

 
 
func provide_buffs():
	super.provide_buffs()
	supported_entity.action_component.update_action_range_modifier("observer", 1)

func exit():
	if supported_entity != null:
		supported_entity.action_component.update_action_range_modifier("observer", 0)
	super.exit()

 
