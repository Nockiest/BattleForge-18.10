class_name ObserveStateProviding
extends   SupportStateProviding

 
 
#func provide_buffs():
#	super.provide_buffs()
#	if current_support_state == SupportStates.ProvidingSupport:
#		print(supported_entity  , "SUPPORTED UNIT  ")
#		print(supported_entity.action_component , "SUPPORTED UNIT ACTION COMPONENT  ")
#		print(supported_entity.action_component.get("aciton_range_modifiers"), "SUPPORTED UNIT ACTION COMPONENT MODIFIERS")
#		print(supported_entity.action_component.get("aciton_range_modifiers")["observer"], "SUPPORTED UNIT ACTION COMPONENT MODIFIERS")
#		var support_entity_action_comp = supported_entity.action_component.get("aciton_range_modifiers")
#		support_entity_action_comp["observer"] = 1
#		supported_entity.action_component.update_from_observer_boost()
#
#func stop_supporting():
#	if supported_entity != null:
#		var support_entity_action_comp = supported_entity.action_component.get("aciton_range_modifiers")
#		support_entity_action_comp["observer"] = 0
#		supported_entity.action_component.update_from_observer_boost()
#	super.stop_supporting()
#
#func _on_area_entered(area):
#	if area.get_parent() is MeleeUnit:
#		return
#	super._on_area_entered(area)
