class_name ReachabilityCheckerComp
extends Node2D

@export var entity_mask_indexes:Array = []
func check_position_reachable(point, projectile_size):
	print("CHECKING POSITION REACHABLE")
	var raycast = RayCast2D.new()
	raycast.hide()
	var collision_shape = CollisionShape2D.new()
	raycast.add_child(collision_shape)

	# Create a RectangleShape2D to represent the width of the "ray"
	var rectangle_shape = RectangleShape2D.new()
	rectangle_shape.extents = Vector2(projectile_size, projectile_size)  # Adjust the width here

	# Set the shape of the CollisionShape2D
	collision_shape.shape = rectangle_shape
	for index in range(16):
		if index in entity_mask_indexes:
			raycast.set_collision_mask_value(index , true)
		else:
			raycast.set_collision_mask_value(index, false)
#		rasycast.set_collision_mask_value(1, true)
	add_child(raycast)
	raycast.collide_with_areas = true
	# Set the starting position of the ray (assuming your units have a position property)
	raycast.position = position#unit.position

	# Set the direction and length of the ray to reach the target unit
	raycast.target_position = to_local(point )#- target_unit.position
#		for index in attack_obstructions_layer_indexes:
	# Check if the ray hits anything
	raycast.force_raycast_update()
#	var timer = Timer.new()
#	timer.wait_time = 2.0  # Set the time in seconds
#	timer.one_shot = true
#	add_child(timer)
#	timer.start()

#	timer.connect("timeout", _on_timer_timeout   )
	print("is colliding? ",raycast.is_colliding())
	if raycast.is_colliding():
	# There is an obstruction between the units
		print(raycast.get_collider(),"  ", raycast.get_collision_point(), "COLLIDING")
#		print("Obstruction detected between ", unit.unit_name, " and ", owner.unit_name)
#		raycast.queue_free()
		return false
	else:
		print("ISNT COLLIDING")
		return true
		
 
 
 
