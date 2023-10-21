class_name RangedActiveActionState
extends BaseActiveActionState

func check_can_enter_state():
	print("UNIT AMMO ", AttackComponent.ammo_component.ammo )
	if AttackComponent.ammo_component.ammo <= 0:
		return false
	return super.check_can_enter_state()

func attack():
	super.attack()
	var direction = ( Globals.hovered_unit.get_node("Center").global_position  - AttackComponent.global_position).normalized()
	shoot_bullet( AttackComponent.owner.get_node("Center").global_position , direction)
	AttackComponent.ammo_component.ammo -=1
 
func check_can_attack():
	var overlapping_areas = AttackComponent.owner.get_node("CollisionArea").get_overlapping_areas()
	print("COLAREA",  AttackComponent.owner.get_node("CollisionArea"),  AttackComponent.owner.get_node("CollisionArea").get_overlapping_areas())
	for area in overlapping_areas:
		if area.get_parent().get_parent() is Forrest:
			print("RANGED UNIT IS IN FORREST",area.get_parent().get_parent() )
			return false
	print("AMMO ", AttackComponent.ammo_component.ammo )
	if AttackComponent.ammo_component.ammo < 0:
		return false
	return super.check_can_attack()
	
func shoot_bullet(pos, direction):
	var bullet = AttackComponent.projectile_scene.instantiate() as Area2D
	# Set the position and direction of the bullet
	var collision_shape = bullet.get_node("CollisionShape2D")  # Replace with your actual collision shape node name
	print(collision_shape, "COL")
 
 
	bullet.position = pos #- shape_size / 2   # Adjust the position so that the center of the shape is at pos
	bullet.direction = direction
	bullet.color =  AttackComponent.owner.color
	bullet.action_range = AttackComponent.action_range
	bullet.shooting_unit =   AttackComponent.owner
	# Make the bullet face its direction
	var target_pos = pos + direction * 100
	var target_angle = (target_pos - pos).angle() + PI/2
	bullet.rotation = target_angle

	# Add the bullet to the projectiles node
	var projectiles = get_tree().get_root().get_node("BattleGround").get_node("Projectiles")
	projectiles.add_child(bullet)
	print("BULLET SHOT", projectiles)

#	print(direction.angle(), direction)
#
	# Calculate the new position for the blast animation
	var blast_displacement = direction.normalized() * 50
	AttackComponent.get_node("BlastAnimation").position += blast_displacement
	AttackComponent.get_node("BlastAnimation").show()
	AttackComponent.get_node("BlastAnimation").rotation = direction.angle() - PI/2 *3
	AttackComponent.get_node("BlastAnimation").play("blast")  # Replace "blast" with the name of your animation
	# Rotate the AnimatedSprite to face the same direction as the bullet	
#	var shape = collision_shape.shape
#	var shape_size = Vector2(0,0) 
##	if shape is RectangleShape2D or shape is CapsuleShape2D:
##		shape_size = shape.get_extents() * 2  # Calculate the size of the shape
#	if shape is CircleShape2D:
#		var radius = shape.get_radius()
#		shape_size = Vector2(radius, radius) * 2
#	else:
#		print("Unsupported shape type")
 

## Called when the node enters the scene tree for the first time.
#func enter(msg = {}):
#	print("ENTERING ACTION STATE")
#	if ! check_can_enter():
#		state_machine.transition_to("Idle") #####################gotta repair this line it is invalid
#		return
#	Globals.action_taking_unit = owner
#	Globals.attacking_component = self
#	$"../..".get_node("AttackRangeCircle").show()
#	check_units_in_range_attackable()
#	highlight_units_in_range()
#
#
#func check_can_enter() -> bool:  
#	if Globals.action_taking_unit == owner:
#		return false
#	if Globals.hovered_unit != owner:
#		return false
#	if Globals.action_taking_unit != null:
#		return  false
#	if AttackComponent.remain_actions < 0:
#		return false
#	return true
#
#
#func check_units_in_range_attackable():
#	for unit in AttackComponent.units_in_action_range:
#		# Create a new RayCast2D
#		if AttackComponent.get_node("reachabilityCheckerComp").check_position_reachable(unit.center, AttackComponent.projectile_size):
#			AttackComponent.reachable_units.append(unit)
#
#
#func exit():
#	print("EXITING ACTION STATE")
##	exiting_action_state.emit()
#	unhighlight_units_in_range()
##	current_state = States.Idle
#	Globals.action_taking_unit = null
#	Globals.attacking_component = null
#	AttackComponent.reachable_units = []
#	AttackComponent.get_node("AttackRangeCircle").hide()
#
#func try_attack( ):
#	print("processing", Globals.hovered_unit,Globals.action_taking_unit  )
#	if !check_can_attack():
#		AttackComponent.get_node("ErrorSound").play()
#		print("FAILED ",self, self.get_parent(),  check_can_attack() )
#		state_machine.transition_to("Idle")
#		return  "FAILED" 
#	attack()
#	return "SUCESS"
#
### ranged attack has an overide for this function  
#func attack():
#	Globals.last_attacker = owner
#	AttackComponent.get_node("ActionSound").play()
#	state_machine.transition_to("Idle")
#
#
#func check_can_attack() -> bool:
#	print("GLOBALS ", Globals.action_taking_unit, owner, Globals.action_taking_unit == owner )
#	if  Globals.action_taking_unit != owner:
#		print_debug(1, Globals.action_taking_unit)
#		return false
#	if not Globals.hovered_unit:
#		print_debug(2,   Globals.hovered_unit)
#		return false
#	if Globals.hovered_unit.color == owner.color:
#		print_debug(3,  Globals.hovered_unit.color , owner.color)
#		return false
#	if AttackComponent.remain_actions <= 0:
#		print_debug(4,  AttackComponent.remain_actions)
#		return false
#	if not Globals.hovered_unit in AttackComponent.reachable_units:
#		print_debug(5)
#		return false
#	print_debug(6)
#	return true
#
#
#func update(_delta:float):
#	if Input.is_action_just_pressed("right_click") :
#			AttackComponent.owner.process_action()
#
#
#func highlight_units_in_range() -> void: 
#	print("HIGHLIGHTING UNITS", AttackComponent.units_in_action_range, )
#	print("REACHABLE UNITS ",  AttackComponent.reachable_units)
#	for unit in AttackComponent.units_in_action_range:
#		if unit in AttackComponent.reachable_units:
#			unit.get_node("ColorRect").modulate = Color(AttackComponent.highlight_color)
#		else:
#			unit.get_node("ColorRect").modulate = Color(0.1,0.1,0.1,0.5)
#
#
#func unhighlight_units_in_range() -> void:
#	for enemy in AttackComponent.units_in_action_range:
#		enemy.get_node("ColorRect").modulate = enemy.color
