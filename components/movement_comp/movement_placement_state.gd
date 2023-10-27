extends MovementState
@onready var buy_areas = get_tree().get_nodes_in_group("buy_areas")

func enter(_msg= []):
	MoveComp.owner.is_newly_bought = true
	Globals.placed_unit = MoveComp.owner
#	MoveComp.owner.change_state_to("Moving")
func exit():
	MoveComp.owner.is_newly_bought = false
	MoveComp.global_start_turn_position =MoveComp.owner.center#center
	MoveComp.owner.is_newly_bought = false
	StatsTracker.increase_stat_by("spent_money",Globals.cur_player, MoveComp.owner.cost)
	if Globals.placed_unit == MoveComp.owner:
		Globals.placed_unit = null
#	MoveComp.owner.change_state_to("Idle")
func update(_delta):
	MoveComp.owner.position = MoveComp.get_global_mouse_position() - MoveComp.owner.size / 2
	if Input.is_action_just_pressed("left_click"):
		process_unit_placement()
	elif Input.is_action_just_pressed("right_click"):
		print("REFUNDING UNIT")
		MoveComp.owner.queue_free()
			
func process_unit_placement():
	if Globals.hovered_unit != null and Globals.hovered_unit != MoveComp.owner:
		print(Globals.hovered_unit == null, Globals.hovered_unit, "POSITION CANNOT BE SET")
		return
	var in_valid_buy_area = false
	## check wheter it is being placed inside the buy bar
	for buy_area in buy_areas:
#			print("COLORS",Color(buy_area.team) , color, buy_area.units_inside)
		if Color(buy_area.team) != MoveComp.owner.color:
			continue  
		if MoveComp.owner not in buy_area.units_inside:
			continue
		print("IN BUY AREA")
		in_valid_buy_area = true
	## check wheter it is placed in and of the occupied cities
	for town in get_tree().get_nodes_in_group("towns"):
		if town.team_alligiance == null:
			continue
		if Color(town.team_alligiance)!= MoveComp.owner.color:
			continue
		if MoveComp.owner in town.units_inside:
			print("UNIT IS INSIDE OF AN OCCUPIED CITY")
			in_valid_buy_area = true
	
	for river_segment in get_tree().get_nodes_in_group("river_segments"):
#			print(river_segment.get_node("Area2D"), river_segment.get_node("Area2D").get_overlapping_areas ( ))
		for area in  river_segment.get_node("Area2D").get_overlapping_areas ( ):
			if area == MoveComp.owner.get_node("CollisionArea"):
				print(area, " OVERLAPS")
				in_valid_buy_area = false
				break

	if in_valid_buy_area:
		print(Globals.hovered_unit,"CAN PLACE A UNIT")
 
		state_machine.transition_to("Idle")
		return
	else:
		$"../../ErrorSound".play()
	print(Globals.hovered_unit, in_valid_buy_area, "POSITION CANNOT BE SET")
