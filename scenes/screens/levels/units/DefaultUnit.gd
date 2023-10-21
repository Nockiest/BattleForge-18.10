extends Node2D
class_name BattleUnit
signal unit_selected 
signal unit_deselected 
signal interferes_with_area
signal bought(cost)
signal died(this)
const base_movement:int = 1
@export var base_movement_range:int = 250 
@export var cost:int = 20  
@export var action_range = 100 
## tohle budu mwnit nodem
var action_component
#@export var movement_comp:Node 
@onready var center = $Center.global_position
@onready var size = $CollisionArea/CollisionShape2D.shape.extents * 2 
@onready var buy_areas = get_tree().get_nodes_in_group("buy_areas")
var attack_resistances =  {"base_resistance":  0.1  } 
var color: Color  
var unit_name: String = "default"
#var start_hp: int = 2
var outline_node
var is_newly_bought:bool = true:
	get:
		return is_newly_bought
	set(new_value):
		is_newly_bought = new_value
		if new_value == false and get_tree() != null:
			var tween = get_tree().create_tween()
			tween.tween_property($ColorRect, "modulate", Color(1,1,1), 0.2)
			tween.tween_property($ColorRect, "modulate",   color, 0.2)
 
func _ready(): 
	# The code here has to come after the code in th echildren compoennts
#	$HealthComponent.hp = start_hp
	$movement_comp.base_movement_range = base_movement_range
	$Center.position = to_local(Utils.get_collision_shape_center($CollisionArea))
	$ErrorAnimation.position = $Center.position  
	center = $Center.global_position 
	$ActionComponent.global_position =  center 
	$movement_comp.global_position = center
	var outline = Utils.polygon_to_line2d($OutlinePolygon , 4) 
	outline_node = outline
	add_child(outline)
	emit_signal("bought", cost)
	if action_component != null:
		action_component.owner = self
		action_component.base_action_range = action_range
	if  is_newly_bought:
		Globals.placed_unit = self
		Globals.hovered_unit = null
		$movement_comp.enter_placed_state()
#	else:
#		$movement_comp.exit_placed_state()
		
	Globals.tenders = get_tree().get_nodes_in_group("player_tenders")
	for tender in Globals.tenders:
		tender.update_tender()
 

func get_boost():
	print("THIS UNIT DOESNT HAVE A BOOST FOR KILLING A UNIT")


func add_to_team(team):
	color = Color(team)
	# Add the unit to a group based on its color
	add_to_group(str(color))
	var color_rect = get_node("ColorRect")
	color_rect.modulate = color
 
func _process(_delta):
	queue_redraw()
	update_stats_bar()
	center = $Center.global_position 
#	if $movement_comp.current_state !=  $movement_comp.state.Moving:
#		action_component.process(_delta)
	if Color(Globals.cur_player) == color:
		$movement_comp.process(_delta)

func _on_movement_comp_ran_out_of_movement():
	call_deferred_thread_group("use_$movement_comp_abort")
	print("POSITION", position, " ", global_position)

func update_for_next_turn():
	$movement_comp.process_for_next_turn()
	if action_component != null:
		action_component.update_for_next_turn()
	else:
		print("DOESNT HAVE AN ACTION COMPONENT TO TOGGLE")
#	if  has_node("HealthComponent"):
#		$HealthComponent.heal(1)

func _on_health_component_hp_changed(hp, prev_hp):
	if color and $ColorRect.is_inside_tree():
		var tween = get_tree().create_tween()
		if hp < prev_hp:
			tween.tween_property($ColorRect, "modulate", Color(0,0,0), 0.2)
		else:
			tween.tween_property($ColorRect, "modulate", Color(1,1,1), 0.2)
		tween.tween_property($ColorRect, "modulate",   color, 0.2)
	if hp <= 0:
		queue_free()

func _on_collision_area_mouse_entered():
	if Globals.placed_unit == self:
		return
	Globals.hovered_unit = self
	toggle_show_information()
 
func _on_collision_area_mouse_exited():
	Globals.hovered_unit = null
	toggle_show_information()
 
func toggle_show_information():
	$UnitStatsBar.visible = !$UnitStatsBar.visible
	$HealthComponent.visible = !$HealthComponent.visible

func update_stats_bar():
	%Health.text = str($HealthComponent.hp)
	%Movement.text =  str($movement_comp.remain_distance)
	%"Movement Modifier".text = str($movement_comp.current_movement_modifier)
	#$RemainMovementLabel.text =  str($movement_comp.current_movement_modifier) + " " + str($movement_comp.on_bridge)    
	if action_component:
		%Actions.text = str(action_component.remain_actions)
 
## here is a call for function spwning a death cross
func _on_tree_exiting():
	var other_units = get_tree().get_nodes_in_group("living_units")
	if Globals.action_taking_unit == self:
		Globals.action_taking_unit = null
	if $HealthComponent.hp == 0:
		StatsTracker.increase_stat_by("lost_units", Globals.color_names[color], 1)
	for unit in other_units:
		if unit == Globals.last_attacker:
			print(unit, " will get a boost")
			unit.get_boost()
	
	#var death_image = death_image_scene.instantiate() as Sprite2D
	#death_image.global_position = $Center.global_position
	#print("RENDERING DEATH CROSS ANIMATION")
	#call_deferred("add_death_cross_to_root", death_image )

#func add_death_cross_to_root(death_image):
#	get_tree().get_root().add_child(death_image )
 


## ranged unit has its own version of this function
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
		elif overlapping is Town:
			$movement_comp.movement_modifiers["in_town"] = -0.25
		$movement_comp.calculate_total_movement_modifier()
	print("NEW MODIFIERS ", $movement_comp.movement_modifiers)
	#print("MOVEMENT MODIFIERS ", Utils.sum_dict_values($movement_comp.movement_modifiers) , $movement_comp.movement_modifiers)
 
func _on_collision_area_area_exited(_area): ## zde je možné, že když rychle vystoupíz jednoho leasa do druhého bude se myslet že není v lese 
	var still_on_bridge = false
	var still_on_road = false
	var still_on_river = false
	var still_on_forrest = false
	var still_in_town = false
	for overlapping in $CollisionArea.get_overlapping_areas():
		if overlapping.get_parent().get_parent() is Forrest:
			still_on_forrest = true #$movement_comp.movement_modifiers["in_forrest"] = 0.5
		elif overlapping.get_parent() is Road:
			still_on_road = true #$movement_comp.movement_modifiers["on_road"] = -0.5
		elif overlapping.get_parent() is Bridge:
			still_on_bridge = true
		elif overlapping.get_parent() is RiverSegment:
			still_on_river = true
		elif overlapping is Town:
			still_in_town = true
	print("AREA EXITED",	$movement_comp.movement_modifiers)
	if not still_on_road:
		$movement_comp.movement_modifiers["on_road"] = 0
	if not still_on_forrest:
		$movement_comp.movement_modifiers["in_forrest"] = 0
	if not still_in_town:
		$movement_comp.movement_modifiers["in_town"] = 0
	$movement_comp.on_bridge = still_on_bridge
	$movement_comp.on_river = still_on_river
	$movement_comp.calculate_total_movement_modifier()

func _on_error_animation_finished():
	$ErrorAnimation.hide()

 
