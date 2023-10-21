class_name RangedAttackComp
extends DefaultAttackComponent
signal ammo_changed(ammo)

@export var ammo_component: Node
@onready var projectile_scene:PackedScene = preload("res://scenes/screens/levels/projectiles/bullet.tscn")
 

func _ready():
	base_action_range = 300
	super._ready()
	$BlastAnimation.hide()
#	ammo = 0 ## smazaz!!
#func toggle_action_screen():
#	if ammo_component.ammo <= 0:
#		return
#
#	super.toggle_action_screen()
#
func update_for_next_turn():
	super.update_for_next_turn()
	ammo_component.ammo += 1
	
 
 
 

 
func _on_ammo_component_ammo_changed():
	ammo_changed.emit(ammo_component.ammo)

 
