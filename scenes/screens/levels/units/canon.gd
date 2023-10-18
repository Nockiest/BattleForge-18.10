extends RangedUnit
class_name Canon

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	unit_name =  "canon"
	action_component.projectile_scene = preload("res://scenes/screens/levels/projectiles/canon_ball.tscn")

 
