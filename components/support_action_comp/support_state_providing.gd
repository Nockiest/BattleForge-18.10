class_name SupportStateProviding
extends SupportState

var supported_entity
 
 
func enter(msg := {}):
	if not  ("suppported_entity" in msg)  :
		print("MSG IS NULL WHEN PROVIDING SUPPORT", msg)
		state_machine.transition_to("Idle")
		return
	supported_entity = msg["suppported_entity"]
	SupportActionNode.get_node("AttackRangeCircle").hide()
  
## this is independent of the parent exit action function
func exit():
	print("STOPPED SUPPORTING")
	SupportActionNode.get_node("SupportConnnection").clear_points()
	supported_entity = null
func update(_delta):
	draw_line_to_supported_entity()
	if Input.is_action_just_pressed("right_click") and Globals.hovered_unit == SupportActionNode.owner:
		state_machine.transition_to("Idle")
#	elif Input.is_action_just_pressed("left_click"):
#		state_machine.transition_to("Idle")
### currently when i want to provide a buff on the enemy turn, it wouldnt work
func provide_buffs() -> bool :
	if $"../..".area_support:
		return false
	if $"../..".owner.color  != Color(Globals.cur_player):
		return false
	var entity_to_buff = supported_entity if SupportActionNode.buffed_variable in supported_entity else Utils.find_child_with_variable(supported_entity, SupportActionNode.buffed_variable)
	print(entity_to_buff, "ENTITY TO BUFF")
	if entity_to_buff and entity_to_buff.get(SupportActionNode.buffed_variable) != null:
		entity_to_buff.set(SupportActionNode.buffed_variable, entity_to_buff.get(SupportActionNode.buffed_variable) + SupportActionNode.increase_ammount)
	return true
#
 
func update_for_next_turn():
	provide_buffs()
#
# 
func draw_line_to_supported_entity():
	var support_connecction =SupportActionNode.get_node("SupportConnnection")
	support_connecction.clear_points()  # Clear any existing points
	if supported_entity != null:
		# Convert global positions to Line2D's local space
		var local_start =SupportActionNode.to_local( SupportActionNode.owner.get_node("Center").global_position ) # $SupportConnnection.to_local(owner.center)
		var local_end = SupportActionNode.to_local( supported_entity.get_node("Center").global_position    ) #$SupportConnnection.to_local( supported_entity.center  )  
		support_connecction.add_point(local_start)  # Add the parent's position as a point
		support_connecction.add_point(local_end )  # Add the supported entity's position as a point
		# Calculate the distance between the start and end points
		if not SupportActionNode.get_overlapping_areas().has(supported_entity.get_node("CollisionArea")):
			state_machine.transition_to("Idle")
			return

		var distance = local_start.distance_to(local_end)
		if distance > SupportActionNode.action_range:
			state_machine.transition_to("Idle")
			return

#
