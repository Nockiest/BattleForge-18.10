extends CanvasLayer

func _on_start_screen_btn_pressed():
	get_tree().change_scene_to_file("res://scenes/screens/StartGameScreen/start_screen.tscn")# 
	StatsTracker.reincrease_stat_bys()
func _ready():
	$AudioStreamPlayer.play()
	show_game_stats()
func show_game_stats():
	$"Stats Bar/VBoxContainer/BlueSpent".text = "Blue Spent " + str( StatsTracker.spent_money["blue"])
	$"Stats Bar/VBoxContainer/RedSpent".text = "Red Spent " +str( StatsTracker.spent_money["red"])
	$"Stats Bar/VBoxContainer/BlueKilled".text = "Blue Lost " +str( StatsTracker.lost_units["blue"])
	$"Stats Bar/VBoxContainer/RedKilled".text ="Red Lost "  +str(   StatsTracker.lost_units["red"])
	$"Stats Bar/VBoxContainer/BlueEarned".text ="Blue Earned "  +str(   StatsTracker.earned_money["blue"])
	$"Stats Bar/VBoxContainer/RedEarned".text ="Red Earned "  +str(   StatsTracker.earned_money["red"])
	$"Stats Bar/VBoxContainer/GameLasted".text ="Game Lasted "  + str( StatsTracker.turns_played) + " Turns"
	$Label.text = str(StatsTracker.winner.to_upper()) + " WON THE GAME" 
	$Label.modulate = Color(StatsTracker.winner)
