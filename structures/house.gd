extends Area2D
class_name House
signal house_interferes
func _on_area_entered(area):
	if area  is House:
		emit_signal("house_interferes", area)
