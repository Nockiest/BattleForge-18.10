extends RessuplyAction
class_name ArearResupplyAction
var resupply_range = 300
 
func _ready():
	area_support = true
	# Assuming that CollisionShape2D is a direct child of the current node
	var collision_shape = get_node("CollisionShape2D")
	if collision_shape and collision_shape.shape is CircleShape2D:
		collision_shape.shape.set_radius(resupply_range)
	$AnimatedSprite2D.hide()
	super._ready()
func provide_buffs():
	var units = get_tree().get_nodes_in_group("living_units")
	for unit in units:
		var unit_center = unit.get_node("Center").global_position
#		print(unit_center.distance_to(global_position), " ", unit_center, " ", global_position, " " ,resupply_range )
		if unit_center.distance_to(global_position) > resupply_range:
			continue
#		var resupply_node = unit.get_node("RangedAttackComp")
		
		if   unit is RangedUnit:#.has_node( "RangedAttackComp") :
			#var ranged_attack_comp = unit.get_node("RangedAttackComp")
			print("GIVING UNIT AMMO ", unit)
			unit.action_component.ammo_component.ammo += 1
#			Utils.play_animation_at_position($AnimatedSprite2D , "resupply_animation"  , unit.get_node("Center").global_position)
 
