extends SupportState

 
func enter(msg:={}):
	$"../../AttackRangeCircle".show()

#func start_supporting(new_supported_entity):
#	current_support_state = SupportStates.ProvidingSupport
#	supported_entity = new_supported_entity
#	#if   supported_entity.has(  "action_component")  :
#	if  "action_component" in supported_entity:
#		supported_entity.action_component.exit_action_state()
#	print("CUR STATE ",current_support_state, )
### this is independent of the parent exit action function
#func stop_supporting():
#	print("STOPPED SUPPORTING")
##	exit_action_state()
#	current_support_state = SupportStates.Idle
#	supported_entity = null
##	unhighlight_units_in_range()
#

#func check_can_support():
#	if Globals.hovered_unit == owner or Globals.hovered_unit == null or Globals.hovered_unit == supported_entity:
#		return false
#	if Globals.hovered_unit.color != owner.color:
#		print(owner," 2")
#		return false
#	if Globals.action_taking_unit  != owner:
#		print(owner," 3")
#		return false
#	if  Utils.get_collision_shape_center( owner.get_node("CollisionArea") ).distance_to(Utils.get_collision_shape_center(owner.get_node("CollisionArea") )) > action_range:
#		print(owner," 5")
#		return false
#	return true
#

#func choose_supported():
##	print("CHOOSING SUPPORTED", check_can_support())
#	if not check_can_support():
#		stop_supporting() 
#		exit_action_state()
#		return
#	print("STARTING TO SUPPORT")
#	start_supporting(Globals.hovered_unit)
##	supported_entity = Globals.hovered_unit
#	exit_action_state()
#	return "SUCCESS"
#
#
