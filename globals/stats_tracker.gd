extends Node

var earned_money:Array[int] = [10,0]
var killed_units:Array[int] = [100,0]
var spent_money:Array[int] = [0,20]
var turns_played:int = 150

func reset_stats():
	print("RESETTING StatS")
	earned_money  = [0,0]
	killed_units  = [0,0]
	spent_money  = [0,0]
	turns_played  = 0
	
func set_stat(stat, cur_player,value):
	print(stat,cur_player,value)
	if self.stat is Array:
		self.stat[cur_player] = value
	else:
		stat = value
