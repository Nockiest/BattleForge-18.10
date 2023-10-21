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

func _on_collision_area_entered(area):
	if $movement_comp.current_state !=   $movement_comp.state.Moving:
		return
# 
	if area is UnitsMainCollisionArea:
		$movement_comp.abort_movement()
	
	for overlapping in $CollisionArea.get_overlapping_areas():
		if overlapping.get_parent().get_parent() is Forrest:
			$movement_comp.movement_modifiers["in_forrest"] = 0.5
			$movement_comp.current_movement_modifier = Utils.sum_dict_values($movement_comp.movement_modifiers)
			if is_in_forrest():
				$movement_comp.abort_movement()
		elif overlapping.get_parent() is Road:
			$movement_comp.movement_modifiers["on_road"] = -0.5
			$movement_comp.current_movement_modifier = Utils.sum_dict_values($movement_comp.movement_modifiers)
		elif overlapping.get_parent() is Bridge:
			$movement_comp.on_bridge = true
		elif overlapping.get_parent() is RiverSegment and !$movement_comp.on_bridge and  Globals.placed_unit != self and   $movement_comp.movement_modifiers["on_road"] == 0:
			print("ENETERED RIVER")
			$movement_comp.abort_movement()
		elif  overlapping.get_parent() is RiverSegment:
			print("ENTERED RIVER")
			$movement_comp.on_river = true
		$movement_comp.calculate_total_movement_modifier()
	print("NEW MODIFIERS ", $movement_comp.movement_modifiers)
	#print("MOVEMENT MODIFIERS ", Utils.sum_dict_values($movement_comp.movement_modifiers) , $movement_comp.movement_modifiers)
 
func _on_collision_area_area_exited(_area): ## zde je možné, že když rychle vystoupíz jednoho leasa do druhého bude se myslet že není v lese 
	var still_on_bridge = false
	var still_on_road = false
	var still_on_river = false
	var still_on_forrest = false
	for overlapping in $CollisionArea.get_overlapping_areas():
		if overlapping.get_parent().get_parent() is Forrest:
			still_on_forrest = true #$movement_comp.movement_modifiers["in_forrest"] = 0.5
		elif overlapping.get_parent() is Road:
			still_on_road = true #$movement_comp.movement_modifiers["on_road"] = -0.5
		elif overlapping.get_parent() is Bridge:
			still_on_bridge = true
		elif overlapping.get_parent() is RiverSegment:
			still_on_river = true
	print("AREA EXITED",	$movement_comp.movement_modifiers)
	if not still_on_road:
		$movement_comp.movement_modifiers["on_road"] = 0
		if is_in_forrest():
			$movement_comp.abort_movement()
	if not still_on_forrest:
		$movement_comp.movement_modifiers["in_forrest"] = 0
	$movement_comp.on_bridge = still_on_bridge
	$movement_comp.on_river = still_on_river
	$movement_comp.calculate_total_movement_modifier()
	
func is_in_forrest() -> bool:
	var on_road = false
	var in_forrest = false
	
	for overlapping in $CollisionArea.get_overlapping_areas():
		if overlapping.get_parent().get_parent() is Forrest:
			in_forrest = true #$movement_comp.movement_modifiers["in_forrest"] = 0.5
		elif overlapping.get_parent() is Road:
			on_road = true #$movement_comp.movement_modifiers["on_road"] = -0.5
	if not on_road and in_forrest:
		return true
	else:
		return false
