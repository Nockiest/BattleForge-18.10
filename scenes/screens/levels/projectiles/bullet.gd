class_name Bullet
extends Projectile
 
func _on_area_entered(area):
	if not super._on_area_entered(area):
		return
	var parent = area.get_parent()
	#if area != parent.get_node("CollisionArea"):
	#	return
	if "color" in parent:
		if color == parent.color:
			return
	
	if parent.has_node("HealthComponent"):
		parent.get_node("HealthComponent").hit(1)
		_play_explosion() ## this should also remove the bullet


func _play_explosion():
	if super._play_explosion():
		$BulletFlyingAnimation.hide()
