class_name RangedActiveActionState
extends BaseActiveActionState

func check_can_enter_state():
#	print("UNIT AMMO ", AttackComponent.ammo_component.ammo )
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
	if AttackComponent.owner.current_terrain == "forrest":
		print("IN FORREST")
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
 
 
