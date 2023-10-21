extends SupportState


 
 

  
#func process(_delta):
##	super.process(_delta)
##	if current_support_state == SupportStates.ProvidingSupport:
#	draw_line_to_supported_entity()
#
 
### currently when i want to provide a buff on the enemy turn, it wouldnt work
#func provide_buffs():
#	if area_support:
#		return
#	if owner.color  != Color(Globals.cur_player):
#		return
#	if supported_entity:
#		var entity_to_buff = supported_entity if buffed_variable in supported_entity else Utils.find_child_with_variable(supported_entity, buffed_variable)
#		print(entity_to_buff, "ENTITY TO BUFF")
#		if entity_to_buff and entity_to_buff.get(buffed_variable) != null:
#			entity_to_buff.set(buffed_variable, entity_to_buff.get(buffed_variable) + increase_ammount)
#
#
 
#func update_for_next_turn():
#	provide_buffs()
#
# 
#func draw_line_to_supported_entity():
#	$SupportConnnection.clear_points()  # Clear any existing points
#	if supported_entity != null:
#		# Convert global positions to Line2D's local space
#		var local_start =to_local(owner.get_node("Center").global_position ) # $SupportConnnection.to_local(owner.center)
#		var local_end = to_local( supported_entity.get_node("Center").global_position    ) #$SupportConnnection.to_local( supported_entity.center  )  
#		$SupportConnnection.add_point(local_start)  # Add the parent's position as a point
#		$SupportConnnection.add_point(local_end )  # Add the supported entity's position as a point
#		# Calculate the distance between the start and end points
#		if not  get_overlapping_areas().has(supported_entity.get_node("CollisionArea")):
#			stop_supporting()
#
#
#		var distance = local_start.distance_to(local_end)
#		if distance > action_range:
#			stop_supporting()
#			return
#
#
