extends BattleUnit
class_name RangedUnit
 
@export var start_ammo = 3
 
func _ready():
	action_component = $ActionComponent/RangedAttackComp 
	action_component.ammo_component.max_ammo = start_ammo 
	super._ready()
	unit_class = "ranged_unit"


func update_stats_bar():
	super.update_stats_bar()
	if action_component:
		%Ammo2.text =  str(action_component.ammo_component.ammo)
 

func _on_collision_area_area_entered(area):
	super._on_collision_area_entered(area)
#
#func _on_river_crossed():
#	super._on_river_crossed()
#
### 
##	if area is UnitsMainCollisionArea:
##		$movement_comp/State/Moving.abort_movement()
#	super._on_collision_area_entered(area)
#	if area .get_parent().get_parent() is Forrest:
#		if is_in_forrest():
#				$movement_comp/State/Moving.abort_movement()
#	for overlapping in $CollisionArea.get_overlapping_areas():
#		if overlapping.get_parent().get_parent() is Forrest:
#			$movement_comp.movement_modifiers["in_forrest"] = 0.5
#			$movement_comp.current_movement_modifier = Utils.sum_dict_values($movement_comp.movement_modifiers)
##			if is_in_forrest():
##				$movement_comp/State/Moving.abort_movement()
#		elif overlapping.get_parent() is Road:
#			$movement_comp.movement_modifiers["on_road"] = -0.5
#			$movement_comp.current_movement_modifier = Utils.sum_dict_values($movement_comp.movement_modifiers)
#		elif overlapping is Town:
#			$movement_comp.movement_modifiers["in_town"] = -0.25
#		elif overlapping.get_parent() is Bridge:
#			$movement_comp.on_bridge = true
#		elif overlapping.get_parent() is RiverSegment and !$movement_comp.on_bridge and  Globals.placed_unit != self and   $movement_comp.movement_modifiers["on_road"] == 0:
#			print("ENETERED RIVER")
#			$movement_comp/State/Moving.abort_movement()
#		elif  overlapping.get_parent() is RiverSegment:
#			print("ENTERED RIVER")
#			$movement_comp.on_river = true
#		$movement_comp.calculate_total_movement_modifier()
#	print("NEW MODIFIERS ", $movement_comp.movement_modifiers)
	#print("MOVEMENT MODIFIERS ", Utils.sum_dict_values($movement_comp.movement_modifiers) , $movement_comp.movement_modifiers)
 
#func _on_collision_area_area_exited(area): ## zde je možné, že když rychle vystoupíz jednoho leasa do druhého bude se myslet že není v lese 
#	var still_on_bridge = false
#	var still_on_road = false
#	var still_on_river = false
#	var still_on_forrest = false
#	var still_in_town =false
#	for overlapping in $CollisionArea.get_overlapping_areas():
#		if overlapping.get_parent().get_parent() is Forrest:
#			still_on_forrest = true #$movement_comp.movement_modifiers["in_forrest"] = 0.5
#		elif overlapping.get_parent() is Road:
#			still_on_road = true #$movement_comp.movement_modifiers["on_road"] = -0.5
#		elif overlapping.get_parent() is Bridge:
#			still_on_bridge = true
#		elif overlapping is Town:
#			still_in_town = true
#		elif overlapping.get_parent() is RiverSegment:
#			still_on_river = true
#	if not still_on_road:
#		$movement_comp.movement_modifiers["on_road"] = 0
#		if area.get_parent()  is Road and is_in_forrest():
#			$movement_comp/State/Moving.abort_movement()
#	if not still_on_forrest:
#		$movement_comp.movement_modifiers["in_forrest"] = 0
#	if not still_in_town:
#		$movement_comp.movement_modifiers["in_town"] = 0
#	$movement_comp.on_bridge = still_on_bridge
#	$movement_comp.on_river = still_on_river
#	$movement_comp.calculate_total_movement_modifier()
#
#func is_in_forrest() -> bool:
#	var on_road = false
#	var in_forrest = false
#
#	for overlapping in $CollisionArea.get_overlapping_areas():
#		if overlapping.get_parent().get_parent() is Forrest:
#			in_forrest = true #$movement_comp.movement_modifiers["in_forrest"] = 0.5
#		elif overlapping.get_parent() is Road:
#			on_road = true #$movement_comp.movement_modifiers["on_road"] = -0.5
#	if not on_road and in_forrest:
#		return true
#	else:
#		return false
