extends BattleUnit
class_name SupportUnit
 
 
## I will recode this using a signal
#func move():
##	super.move()
#	action_component.deselect_supported_entity()  #supported_entity = null
 
func _on_support_action_invalid_support():
	print("invaliid_action") 
	
func _ready():
	super._ready()
	unit_name = "support_unit"
## override for the supper funcion
func process_action():
#	action_component.toggle_action_screen()
	if Globals.action_taking_unit == self:
	#		action_component.highlight_units_in_range()
		print("CHOOSING SUPPORTED")
		action_component.choose_supported()
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
