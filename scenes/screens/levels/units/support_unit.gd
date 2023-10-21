extends BattleUnit
class_name SupportUnit
 
 
func _ready():
	super._ready()
	unit_name = "support_unit"
## This Should Be in the support action
#func process_action():
##	action_component.toggle_action_screen()
#	if Globals.action_taking_unit == self:
#	#		action_component.highlight_units_in_range()
#		print("CHOOSING SUPPORTED")
#		action_component.choose_supported()
#
		
#	print("DOING SUPPORTING ACTION")
#	do_supporting_action()
 
#func toggle_action_screen():
#	super.toggle_action_screen()
#	if Globals.action_taking_unit == self:
#		Globals.action_taking_unit = null
#	elif Globals.hovered_unit != self:
#		return
#	else:
#		Globals.action_taking_unit = self
#
#	action_component = support_action  
#	action_component.support_component_owner = self
#	support_action.support_component_owner = self
#	support_action.owner = self
#	action_component = support_action
