class_name BaseActiveActionState
extends ActionState


# Called when the node enters the scene tree for the first time.
func enter(_msg = {}):
	if ! check_can_enter_state():
		state_machine.transition_to("Idle") #####################gotta repair this line it is invalid
		return
	Globals.action_taking_unit = AttackComponent.owner
	Globals.attacking_component = self
#	print("ENTERING ACTION STATE ",  Globals.action_taking_unit )
	$"../..".get_node("AttackRangeCircle").show()
	find_attackable_units()
	highlight_units_in_range()
	
			
func check_can_enter_state() -> bool:  
	if Globals.action_taking_unit ==AttackComponent.owner:
		return false
	if Globals.hovered_unit != AttackComponent.owner:
		return false
	if Globals.action_taking_unit != null:
		return  false
	if AttackComponent.remain_actions <= 0:
		return false
	print("COLORS ",AttackComponent.owner.color, Color(Globals.cur_player))
	if AttackComponent.owner.color != Color(Globals.cur_player):
		return false
	return true
 

func find_attackable_units():
	for unit in AttackComponent.units_in_action_range:
		# Create a new RayCast2D
		if AttackComponent.get_node("reachabilityCheckerComp").check_position_reachable(unit.center, AttackComponent.projectile_size):
			AttackComponent.reachable_units.append(unit)
 
		
func exit():
	if Globals.action_taking_unit == AttackComponent.owner:
		Globals.action_taking_unit = null
		Globals.attacking_component = null
		AttackComponent.reachable_units = []
		AttackComponent.get_node("AttackRangeCircle").hide()
	unhighlight_units_in_range()
func try_attack( ):
	if !check_can_attack():
		AttackComponent.get_node("ErrorSound").play()
		print("FAILED ",self, self.get_parent(),  check_can_attack() )
		state_machine.transition_to("Idle")
		AttackComponent.get_node("ErrorAnimation")
		return  "FAILED" 
	attack()
	return "SUCESS"
  
func attack():
	Globals.last_attacker = AttackComponent.owner
	AttackComponent.get_node("ActionSound").play()
	state_machine.transition_to("Idle")
	AttackComponent.remain_actions -=1

func check_can_attack() -> bool:
#	print("check_can_attack ",  Globals.action_taking_unit, AttackComponent.owner, Globals.action_taking_unit == AttackComponent.owner )
	if  Globals.action_taking_unit != AttackComponent.owner:
		print_debug(1, Globals.action_taking_unit)
		return false
	if not Globals.hovered_unit:
		print_debug(2,   Globals.hovered_unit)
		return false
	if Globals.hovered_unit.color == AttackComponent.owner.color:
		print_debug(3,  Globals.hovered_unit.color , AttackComponent.owner.color)
		return false
	if AttackComponent.remain_actions <= 0:
		print_debug(4,  AttackComponent.remain_actions)
		return false
	if not Globals.hovered_unit in AttackComponent.reachable_units:
		print_debug(5)
		return false
	print_debug(6)
	return true
	

func update(_delta:float):
	if Input.is_action_just_pressed("right_click") :
		try_attack()#AttackComponent.owner.process_action()
	elif Input.is_action_just_pressed("left_click") :
		state_machine.transition_to("Idle")#AttackComponent.owner.process_action()
 

func highlight_units_in_range() -> void: 
#	print("HIGHLIGHTING UNITS", AttackComponent.units_in_action_range, )
#	print("REACHABLE UNITS ",  AttackComponent.reachable_units)
	for unit in AttackComponent.units_in_action_range:
		if unit in AttackComponent.reachable_units:
			unit.get_node("ColorRect").modulate = Color(AttackComponent.highlight_color)
		else:
			unit.get_node("ColorRect").modulate = Color(0.1,0.1,0.1,0.5)


func unhighlight_units_in_range() -> void:
	for enemy in AttackComponent.units_in_action_range:
		enemy.get_node("ColorRect").modulate = enemy.color
