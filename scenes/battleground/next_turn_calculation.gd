extends BattlegroundState
 

func enter(_msg := {}):
	update_elements()
	give_money_income_to_players()
	state_machine.transition_to("Idle" ) 

func update_elements():
	Globals.cur_player_index += 1  
	Globals.action_taking_unit = null
	Globals.moving_unit = null
	## not currently used
	var Supply_depos =  get_tree().get_nodes_in_group("supply_depos") 
	var units = get_tree().get_nodes_in_group("living_units")
	var support_actions = get_tree().get_nodes_in_group("support_actions")
	var towns = get_tree().get_nodes_in_group("towns") 
	var projectiles = get_tree().get_nodes_in_group("projectiles") 
	for unit in units:
		unit.update_for_next_turn()
#	for support_action in support_actions:
#		support_action.provide_buffs()
	for town in towns:
		town.make_next_turn_calculations()
	for depo in Supply_depos:
		var resupply_action = depo.get_node("AreaResupplyAction")
		resupply_action.provide_buffs()
	give_money_income_to_players()
	for tender in Globals.tenders:
		tender.update_tender()
	for projectile in projectiles:
		projectile.speed *= 4
 


func give_money_income_to_players(): 
	var red_towns = 0
	var blue_towns = 0
	var towns = get_tree().get_nodes_in_group("towns")
	for structure in towns:
		if structure.team_alligiance == "red":
			red_towns += 1
		elif structure.team_alligiance == "blue":
			blue_towns += 1
 
	Globals.blue_player_money += Globals.money_per_turn + blue_towns* Globals.city_turn_income
 
	Globals.red_player_money  +=  Globals.money_per_turn + red_towns* Globals.city_turn_income
 
	StatsTracker.increase_stat_by("earned_money", "blue",   Globals.money_per_turn + blue_towns* Globals.city_turn_income )  # Set the first element of 'earned_money' to 50
	StatsTracker.increase_stat_by("earned_money", "red",  Globals.money_per_turn + red_towns* Globals.city_turn_income)  # Set the first element of 'earned_money' to 50
 
