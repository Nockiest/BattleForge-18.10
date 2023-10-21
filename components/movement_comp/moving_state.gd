extends State
#
#var parent: MovementComponent
#var mouse_pos_offset
#var global_start_turn_position
#var current_movement_modifier
#func enter():
#	print("ENTEREING MOVEMENT STATE")
#	Globals.moving_unit = owner
#	Globals.action_taking_unit = null
#	print("TURNING MOVEMENT LOOK ON")
#	mouse_pos_offset = parent.position.distance_to(get_global_mouse_position())
#	global_start_turn_position = parent.position
#	toggle_moving_appearance("on")
##	current_state = state.Moving
#func exit ():
##	current_state = state.Idle
#	toggle_moving_appearance("off")
#	if Globals.moving_unit == owner:
#		Globals.moving_unit = null
#	owner.global_position = global_start_turn_position
#
#func toggle_moving_appearance(toggle):
#	if toggle == "on":
#		print("TURNING MOVING APPEARANCE ON")
#		parent.outline_node.modulate = Color("black")
#		parent.get_node("ColorRect").modulate = Color("gray")
#	elif toggle == "off":
#		parent.outline_node.modulate = Color("white")
#		parent.get_node("ColorRect").modulate = Color(parent.color)
#	else:
#		print("ARGUMENT ", toggle)
#		assert(false, "TOGGLE MOVEMENT COLOR GOT BAD ARGUMENT" )


#func calculate_total_movement_modifier():
#	current_movement_modifier = Utils.sum_dict_values(movement_modifiers)
#	print("RECALCULATING MOVEMENT MODIFIERS")
#func process(delta):
#	if current_state == state.Moving:
#		call_deferred_thread_group("move", owner.size)# move(owner.size)
#
#
#func move(size_of_scene):
#	## get the current position of the parent scene
#	## save it as the last position
#	## compare the distance between the last position and the new position
#	## new position will be the position of the mouse - the mouse offset
#	if Globals.moving_unit != owner:
#		return
#	var mouse_pos = parent.get_global_mouse_position() 
#	var new_position = parent.global_position
#	var distance_just_traveled = 0  #last_position.distance_to(mouse_pos )#0
#	new_position = mouse_pos - size_of_scene / 2#mouse_pos - mouse_pos_offset#mouse_pos - size_of_scene / 2
#	if floor( owner.position.distance_to(mouse_pos) ) <= 1 :
#		distance_just_traveled =  0
#	else:
#		distance_just_traveled = floor( owner.position.distance_to(new_position) ) * current_movement_modifier  
#	remain_distance -= distance_just_traveled
#	owner.position= new_position
#	for unit in get_tree().get_nodes_in_group("living_units"):
#		if unit == owner:
#			continue  # Skip checking collision with itself.
#		print(unit.get_node("CollisionArea").get_overlapping_areas())
#		if unit.get_node("CollisionArea").get_overlapping_areas().has($"."/CollisionArea):
#			abort_movement()
#			exit_movement_state()
#			break
 
#
#func deselect_movement():
#	global_start_turn_position = global_position
#	exit_movement_state()
#
#
#func abort_movement():
#	print("CALLED ABORT MOVEMENT ", global_start_turn_position)
#	Globals.moving_unit = null
#	remain_distance = base_movement_range
#	owner.position = global_start_turn_position
#	call_deferred_thread_group("exit_movement_state")
#
#
#func process_for_next_turn():
#	remain_movement =  base_movement_points
#	remain_distance = base_movement_range
#	set_new_start_turn_point()  
#	owner.position = global_start_turn_position
#
#func  set_new_start_turn_point():
#	print("SETTING NEW START TURN POS",global_position)
#	global_start_turn_position = global_position
