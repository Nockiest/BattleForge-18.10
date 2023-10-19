class_name CanonShell
extends Projectile
var rotation_speed = 10 # The speed of rotation in degrees per second.

## code for cannonball
func _on_area_entered(area):
	if not super._on_area_entered(area):
		return
 
	var parent = area.get_parent()
	#print(area)
	#if area != parent.get_node("CollisionArea"):
	#	return
 
	if parent.has_node("HealthComponent"):
		parent.get_node("HealthComponent").hit(1)
 
func _process(delta):
	super._process(delta)

	# Rotate the cannonball.
	rotation += rotation_speed * delta
func stop_movement():
	super.stop_movement()
	rotation_speed = 0
 
