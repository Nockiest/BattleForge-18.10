class_name SupportStateChoosing
extends SupportState

 
func enter(msg:={}):
	$"../../AttackRangeCircle".show()
	Globals.action_taking_unit =   SupportActionNode.owner
	highlight_units_in_range()
func exit():
	if Globals.action_taking_unit == SupportActionNode.owner:
		Globals.action_taking_unit  = null
		unhighlight_units_in_range()
#	unhighlight_units_in_range()
#
func update(delta):
	if Input.is_action_just_pressed("right_click"):
		choose_supported()
func check_can_support() -> bool:
	if  Globals.hovered_unit == null  :
		print_debug( Globals.hovered_unit ," No Hovere unit")
		return false
	if Globals.hovered_unit.color !=  SupportActionNode.owner.color:
		print_debug( SupportActionNode.owner," 2")
		return false
	if Globals.action_taking_unit  !=  SupportActionNode.owner:
		print_debug( SupportActionNode.owner," 3")
		return false
	if Utils.get_collision_shape_center(SupportActionNode.owner.get_node("CollisionArea")) \
			.distance_to(Utils.get_collision_shape_center(Globals.hovered_unit.get_node("CollisionArea"))) \
			> SupportActionNode.action_range:
		print_debug( SupportActionNode.owner," 5")
		return false
	return true


func choose_supported() ->void:
#	print("CHOOSING SUPPORTED", check_can_support())
	if not check_can_support():
		state_machine.transition_to("Idle")
#		return
	print("STARTING TO SUPPORT")
	state_machine.transition_to("ProvidingSupport", {"suppported_entity" = Globals.hovered_unit}) 
#
func highlight_units_in_range() -> void: 
#	print("HIGHLIGHTING UNITS", AttackComponent.units_in_action_range, )
#	print("REACHABLE UNITS ",  AttackComponent.reachable_units)
	for unit in SupportActionNode.units_in_action_range:
		unit.get_node("ColorRect").modulate = Color(SupportActionNode.highlight_color)
#		if unit in SupportActionNode.reachable_units:
#			unit.get_node("ColorRect").modulate = Color(AttackComponent.highlight_color)
#		else:
#			unit.get_node("ColorRect").modulate = Color(0.1,0.1,0.1,0.5)


func unhighlight_units_in_range() -> void:
	for unit in SupportActionNode.units_in_action_range:
		unit.get_node("ColorRect").modulate = unit.color

 
