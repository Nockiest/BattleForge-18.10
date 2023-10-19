extends Node

signal cur_player_has_been_changed()
signal  player_money_changed( )
 
var red_player_color: Color = Color("ff0000")
var blue_player_color: Color = Color("0000ff")
var players = ["blue", "red"]
var cur_player = "blue"
var hovered_unit
var placed_unit
var hovered_structure
var action_taking_unit
var attacking_component
var moving_unit:
	set(value):
		moving_unit = value
		print("MOVING UNIT CHANGED ", moving_unit)
var last_attacker
var can_start_new_attack = true


var medic_scene:PackedScene =preload("res://scenes/screens/levels/units/medic.tscn")
var observer_scene:PackedScene =preload("res://scenes/screens/levels/units/observer.tscn")
var supply_cart_scene:PackedScene =preload("res://scenes/screens/levels/units/supply_cart.tscn")
var cannon_scene:PackedScene = preload("res://scenes/screens/levels/units/canon.tscn")
var musketeer_scene:PackedScene =preload("res://scenes/screens/levels/units/musketeer.tscn")
var pikeman_scene:PackedScene =preload("res://scenes/screens/levels/units/pikeman.tscn")
var shield_scene:PackedScene =preload("res://scenes/screens/levels/units/shield.tscn")
var knight_scene:PackedScene = preload("res://scenes/screens/levels/units/knight.tscn" )
var commander_scene:PackedScene = preload("res://scenes/screens/levels/units/commander.tscn")
var unit_packed_scenes_arr: Array = [medic_scene,observer_scene,supply_cart_scene, cannon_scene, musketeer_scene, pikeman_scene, shield_scene, knight_scene, commander_scene]
 
#this could cause potential problems in the future
@onready var tenders = get_tree().get_nodes_in_group("player_tenders")
 
  
func update_cur_player():
	cur_player = players[cur_player_index]
	emit_signal("cur_player_has_been_changed") 
 
func end_game(loser):
	print(loser, " lost the game")
	get_tree().change_scene_to_file("res://scenes/screens/EndGameScreen/end_game_screen.tscn")# 
 
var cur_player_index =  0 :
	get:
		return  cur_player_index 
	set(value):
		cur_player_index =  value  % len(players) 
		update_cur_player() 
 
# settings config
var num_towns = 6
var num_rivers = 2
var num_forests = 3
var blue_player_units = {
	'medic': 0,
	'observer': 1,
	'supply_cart': 1,
	'cannon': 0,
	'musketeer': 2,
	'pikeman':1,
	'shield': 1,
	'knight': 1,
	'commander': 1,
}
var blue_player_money = 100:
	get:
		return blue_player_money
	set(value):
		print("BLUE UNITS ", value)
		blue_player_money =  max(0, value )
		player_money_changed.emit( ) #emit_signal("blue_player_money_changed", value)
		for tender in tenders:
			tender.update_tender()
var red_player_money = 100:
	get:
		return red_player_money
	set(value):
		red_player_money = max(0, value )
		player_money_changed.emit( ) #emit_signal("red_player_money_changed", value)
		for tender in tenders:
			tender.update_tender()
var red_player_units = {
	'medic': 0,
	'observer': 1,
	'supply_cart': 1,
	'cannon': 0,
	'musketeer': 2,
	'pikeman':1,
	'shield': 1,
	'knight': 1,
	'commander': 1,
}:
	set(value):
		print("RED UNITS" , value)
		red_player_units= value
var money_per_turn = 10
var city_turn_income = 10
var min_town_spacing_distance = 200
 
## game stats
# var num_turns =  0  
# var num_attacks =  0, 0 
# var killed_units = 0
# var enemies_killed = 0
# var money_spent = 0
# var shots_fired = 0
 
