class_name RangedAttackComp
extends DefaultAttackComponent
signal ammo_changed(ammo)

@export var ammo_component: Node
@onready var projectile_scene:PackedScene = preload("res://scenes/screens/levels/projectiles/bullet.tscn")
 

func _ready():
#	base_action_range = 300
	super._ready()
	$BlastAnimation.hide()
 
func update_for_next_turn():
	super.update_for_next_turn()
	
 
#func update_from_observer_boost():
#	print("UPDATING FROM OBSERVER BOOST")
#	action_range = Utils.sum_dict_values(aciton_range_modifiers)
#
func _on_ammo_component_ammo_changed():
	ammo_changed.emit(ammo_component.ammo)

 
