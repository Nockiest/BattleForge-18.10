extends Node2D
class_name BattleUnit
signal unit_selected 
signal unit_deselected 
signal interferes_with_area
signal bought(cost)
signal died(this)
const base_movement:= 1
@export var base_movement_range:= 250 
@export var cost:= 20  
@export var action_range = 100 
@export var can_move_after_attack = false
@export var can_attack_after_move = true
## tohle budu mwnit nodem
var action_component
#@export var movement_comp:Node 
@onready var center = $Center.global_position
@onready var size = $CollisionArea/CollisionShape2D.shape.extents * 2 
@onready var buy_areas = get_tree().get_nodes_in_group("buy_areas")
@onready var current_terrain = $movement_comp/terrain_type_finder.find_current_overlapping_terrain()
var attack_resistances =  {"base_resistance":  0.1  } 
var color: Color  
var unit_name := "default"
var unit_class := "default"
 
var outline_node
var is_newly_bought:= true:
	get:
		return is_newly_bought
	set(new_value):
		is_newly_bought = new_value
		if new_value == false and get_tree() != null : #and get_tree() != null
			var tween = get_tree().create_tween()
			tween.tween_property($ColorRect, "modulate", Color(1,1,1), 0.2)
			tween.tween_property($ColorRect, "modulate",   color, 0.2)
 

func action_aftermath_handler():
	pass
	print("CAN MOVE AFTER ATTACK? ", can_move_after_attack)
	if !can_move_after_attack:
		$movement_comp.remain_distance = 0
	else:
		print("CAN MOVE AFTER ATTACK")	

func check_can_move_after_attack():
	if !can_attack_after_move:
		if $movement_comp.global_start_turn_position != center:
			action_component.remain_actions = 0

func _ready(): 
	# The code here has to come after the code in th echildren compoennts
	$movement_comp.base_movement_range = base_movement_range
	$Center.position = to_local(Utils.get_collision_shape_center($CollisionArea))
	$movement_comp/State/Moving.connect("aborted_movement", handle_abort_movement)
	$ErrorAnimation.position = $Center.position  
	center = $Center.global_position 
	$ActionComponent.global_position =  center 
#	$terrain_type_finder.global_position = center
	$movement_comp.global_position = center
	var outline = Utils.polygon_to_line2d($OutlinePolygon , 4) 
	outline_node = outline
	add_child(outline)
	emit_signal("bought", cost)
	if action_component != null:
		action_component.owner = self
		print(action_component.base_action_range, action_range)
		action_component.base_action_range = action_range
		if not(self is SupportUnit):
			print("CONNECTED")
			action_component.connect("attack_comp_attacked", action_aftermath_handler)
	if  is_newly_bought:
		Globals.placed_unit = self
		Globals.hovered_unit = null
		
	Globals.tenders = get_tree().get_nodes_in_group("player_tenders")
	for tender in Globals.tenders:
		tender.update_tender()
 
## dirty code
func handle_abort_movement():
	pass
#	action_component.get_node("State").transition_to("Idle")
#	action_component.get_node("State/Active").unhighlight_units_in_range()
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
	handle_show_unit_information()
	if $movement_comp/terrain_type_finder.overlapping_terrain_type == "forest":
		$InForrestSprite.show()
	else:
		$InForrestSprite.hide()
#	if 
#	if $movement_comp.current_state !=  $movement_comp.state.Moving:
#		action_component.process(_delta)
func handle_show_unit_information():
	if Globals.hovered_unit == self:
		$UnitStatsBar.visible = true
		$HealthComponent.visible = false
	elif Globals.hovered_unit != self and $movement_comp/State.state!= $movement_comp/State/Moving:
		$UnitStatsBar.visible = false
		$HealthComponent.visible = true
	else:
		$UnitStatsBar.visible = true
		$HealthComponent.visible = false
	
#
#func _on_movement_comp_ran_out_of_movement():
#	call_deferred_thread_group("use_$movement_comp_abort")

func update_for_next_turn():
	$movement_comp.process_for_next_turn()
	if action_component != null:
		action_component.update_for_next_turn()
	else:
		print("DOESNT HAVE AN ACTION COMPONENT TO TOGGLE")

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
 
func _on_collision_area_mouse_exited():
	Globals.hovered_unit = null
 
func toggle_show_information():
	$UnitStatsBar.visible = !$UnitStatsBar.visible
	$HealthComponent.visible = !$HealthComponent.visible

func update_stats_bar():
	%Health.text = str($HealthComponent.hp)
	%Movement.text =  str($movement_comp.remain_distance)
	%"Movement Modifier".text = str($movement_comp.current_movement_modifier)  
	if action_component:
		%Actions.text = str(action_component.remain_actions)
 
## here is a call for function spwning a death cross
func _on_tree_exiting():
	var other_units = get_tree().get_nodes_in_group("living_units")
	if Globals.action_taking_unit == self:
		Globals.action_taking_unit = null
	if $HealthComponent.hp == 0:
		StatsTracker.increase_stat_by("lost_units", Globals.color_names[color], 1)
	if Globals.placed_unit == self:
		if Globals.cur_player == "red":
			Globals.red_player_money += cost
		else:
			Globals.blue_player_money += cost
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
	if area is UnitsMainCollisionArea:
		print(area.get_parent(), area.get_parent().color != color)
	if $movement_comp/State.state !=   $movement_comp/State/Moving :
		return
	if area is UnitsMainCollisionArea and area.get_parent().color != color:
		print("ABORTING MOVEMENT ", self)
		$movement_comp/State/Moving.abort_movement()
		
func _on_error_animation_finished():
	$ErrorAnimation.hide()

 
