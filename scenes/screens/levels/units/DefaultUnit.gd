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
var start_hp: int = 2
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
	$HealthComponent.hp = start_hp
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


func process_action():
	if  action_component.try_attack() ==  "FAILED":
		$ErrorAnimation.show()
		$ErrorAnimation.play("error")

 
func _process(_delta):
	queue_redraw()
	update_stats_bar()
	center = $Center.global_position 
	if $movement_comp.current_state !=  $movement_comp.state.Moving:
		action_component.process(_delta)
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
	%Health.text =  str($HealthComponent.hp)
	%Movement.text =   str($movement_comp.remain_distance)
	%"Movement Modifier".text = str($movement_comp.current_movement_modifier)
	#$RemainMovementLabel.text =  str($movement_comp.current_movement_modifier) + " " + str($movement_comp.on_bridge)    
	if action_component:
		%Actions.text = str(action_component.remain_actions)
 
## here is a call for function spwning a death cross
func _on_tree_exiting():
	var other_units = get_tree().get_nodes_in_group("living_units")
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
	
#func ___on_movement_changed():
#	update_stats_bar()
 
func _on_collision_area_entered(area):
	if $movement_comp.current_state !=   $movement_comp.state.Moving:
		return
#	if Globals.placed_unit != self and  Globals.placed_unit != null :
#		print("IGNORE AREA ENTERED")
#		return
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
			$movement_comp.abort_movement()##$movement_comp.exit_movement_state()
#		use_$movement_comp_abort()
		if  overlapping.get_parent() is RiverSegment:
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
	if not still_on_forrest:
		$movement_comp.movement_modifiers["in_forrest"] = 0
	$movement_comp.on_bridge = still_on_bridge
	$movement_comp.on_river = still_on_river
	$movement_comp.calculate_total_movement_modifier()

func _on_error_animation_finished():
	$ErrorAnimation.hide()


#func process_unit_placement():
#	if Input.is_action_just_pressed("left_click"): 
#		if Globals.hovered_unit != null:
#			print(Globals.hovered_unit == null, Globals.hovered_unit, "POSITION CANNOT BE SET")
#			return
#		var in_valid_buy_area = false
#		## check wheter it is being placed inside the buy bar
#		for buy_area in buy_areas:
##			print("COLORS",Color(buy_area.team) , color, buy_area.units_inside)
#			if Color(buy_area.team) != color:
#				continue  
#			if self not in buy_area.units_inside:
#				continue
#			print("IN BUY AREA")
#			in_valid_buy_area = true
#		## check wheter it is placed in and of the occupied cities
#		for town in get_tree().get_nodes_in_group("towns"):
#			if town.team_alligiance == null:
#				continue
#			if Color(town.team_alligiance)!= color:
#				continue
#			if self in town.units_inside:
#				print("UNIT IS INSIDE OF AN OCCUPIED CITY")
#				in_valid_buy_area = true
#
#		for river_segment in get_tree().get_nodes_in_group("river_segments"):
##			print(river_segment.get_node("Area2D"), river_segment.get_node("Area2D").get_overlapping_areas ( ))
#			for area in  river_segment.get_node("Area2D").get_overlapping_areas ( ):
#				if area == $CollisionArea:
#					print(area, " OVERLAPS")
#					in_valid_buy_area = false
#					break
#
#		if in_valid_buy_area:
#			print(Globals.hovered_unit,"CAN PLACE A UNIT")
#			is_newly_bought = false
#			Globals.placed_unit = null
#			return
#		print(Globals.hovered_unit, in_valid_buy_area, "POSITION CANNOT BE SET")
#
#
#	if Input.is_action_just_pressed("right_click"): 
#		print("ABORTING BUYING AND GIVING MONEY BACK")
#		queue_free()



#    def find_obstacles_in_line_to_enemies(self, enemy, line_points):
#        # I could only reset the line to that specific unit instead of deleting the whole array
#        ######################### x FIND BLOCKING UNITS ##############
#        blocked = False
#        for unit in game_state.living_units.array:
#            if unit == enemy:
#                continue
#            elif unit.color == self.color:
#                continue
#            point_x, point_y, interferes = check_precalculated_line_square_interference(
#                unit, line_points)
#            distance_between_units = get_two_units_center_distance(unit  , enemy )
#
#            if interferes and abs(distance_between_units )> max(enemy.size//2, unit.size//2):
#                print("this unit is blocking the way", unit, enemy)
#                blocked = True
#                self.lines_to_enemies_in_range.append({
#                    "enemy": enemy,
#                    "start": self.center,
#                    "interference_point": (point_x, point_y),
#                    "end": enemy.center})
#
#                break
#        if not blocked:
#            self.lines_to_enemies_in_range.append({
#                "enemy": enemy,
#                "start": self.center,
#                "interference_point": None,
#                "end": enemy.center})
#
#        return blocked
#
  
#    def draw_lines_to_enemies_in_range(self):
#        for line in self.lines_to_enemies_in_range:
#            start = line["start"]
#            end = line["end"]
#            interference_point = line["interference_point"]
#
#            if interference_point is not None:
#                pygame.draw.line(screen, DARK_RED, start,
#                                 interference_point, 3)
#                pygame.draw.line(screen, (HOUSE_PURPLE),
#                                 interference_point, end, 3)
#            else:
#                pygame.draw.line(screen, DARK_RED, start, end, 3)
#                midpoint = ((start[0] + end[0]) // 2,
#                            (start[1] + end[1]) // 2)
#                distance = math.sqrt(
#                    (start[0] - end[0]) ** 2 + (start[1] - end[1]) ** 2)
#                font = pygame.font.Font(None, 20)
#                text_surface = font.render(
#                    f"{int(distance)} meters", True, WHITE)
#                text_rect = text_surface.get_rect(center=midpoint)
#                screen.blit(text_surface, text_rect)
# 
 

 
#func _draw():
#	var local_start_turn_pos  = to_local(global_start_turn_position)
#	if Globals.moving_unit == self:
#		var fill_color = Utils.lighten_color(color, 0.4)
#		# Draw an arc from 0 to PI radians (half a circle).
#		draw_arc(local_start_turn_pos, base_movement_range, 0,  PI*2, 100, fill_color, 3)
#		# Set the collision shape to match the drawn circle. 

 


func _on_collision_area_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
