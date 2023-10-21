class_name ObserveStateProviding
extends   SupportStateProviding

 
 
func provide_buffs():
	super.provide_buffs()
 
	print(supported_entity  , "SUPPORTED UNIT  ")
	print(supported_entity.action_component , "SUPPORTED UNIT ACTION COMPONENT  ")
	print(supported_entity.action_component.get("aciton_range_modifiers"), "SUPPORTED UNIT ACTION COMPONENT MODIFIERS")
	print(supported_entity.action_component.get("aciton_range_modifiers")["observer"], "SUPPORTED UNIT ACTION COMPONENT MODIFIERS")
	var support_entity_action_comp = supported_entity.action_component.get("aciton_range_modifiers")
	support_entity_action_comp["observer"] = 1
	supported_entity.action_component.update_from_observer_boost()

func exit():
	if supported_entity != null:
		print("supported_entity", supported_entity, supported_entity is Observer)
		var support_entity_action_comp = supported_entity.action_component.get("aciton_range_modifiers")
		support_entity_action_comp["observer"] = 0
		supported_entity.action_component.update_from_observer_boost()
		supported_entity = null
	super.exit()

 
