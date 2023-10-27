extends Node

var earned_money:Dictionary  = {
	"blue": 0,
	"red": 0
}
var lost_units:Dictionary  = {
	"blue": 0,
	"red": 0
}# [100,0]
var spent_money:Dictionary  = {
	"blue": 0,
	"red": 0
}
var turns_played:int =  0
var winner:= "none"
func increase_stat_by(stat, cur_player, value):	
	if stat is Array:
		stat[cur_player] = value
	else:
		# If 'stat' is not an array, it is a variable, and we can't directly assign to it.
		# You can consider using a match statement to handle different variables.
		match stat:
			"earned_money":
				earned_money[cur_player] += value
			"lost_units":
				lost_units[cur_player] += value
			"spent_money":
				spent_money[cur_player] += value
			"turns_played":
				turns_played += value
			# Add more cases for other variables as needed

func reincrease_stat_bys():
	print("RESETTING StatS")
	earned_money   = {
	"blue": 0,
	"red": 0
}
	lost_units  = {
	"blue": 0,
	"red": 0
}
	spent_money  =   {
	"blue": 0,
	"red": 0
}
	turns_played  = 0
 
