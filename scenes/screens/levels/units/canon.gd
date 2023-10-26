class_name Canon
extends RangedUnit
 

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	unit_name =  "canon"
	action_component.projectile_scene = preload("res://scenes/screens/levels/projectiles/canon_ball.tscn")

 
#func _on_river_crossed () -> void:
##	print("RIVER CROSSED ", self)
##	$movement_comp/State/Moving.abort_movement()
#	super._on_river_crossed()
