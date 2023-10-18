extends BattleUnit
class_name RangedUnit
 
var start_ammo = 6
#var bullet_scene:PackedScene = preload("res://scenes/screens/levels/projectiles/bullet.tscn")
func _ready():
	action_component = $ActionComponent/RangedAttackComp 
	action_component.ammo_component.max_ammo = start_ammo 
	action_component.ammo_component.ammo = start_ammo 
#	action_component.action_range = ranged_unit_range
#	action_component.position = to_local(center)
#	action_component.owner =self
	super._ready()
	unit_name = "ranged_unit"
func update_stats_bar():
	super.update_stats_bar()
	if action_component:
		%Ammo2.text =  str(action_component.ammo_component.ammo)
#	$UnitStatsBar/VBoxContainer/Attacks.text = "Attacks "+str(action_component.remain_actions)

func _on_ranged_attack_comp_ammo_changed(_ammo):
	update_stats_bar()
