extends CanvasLayer

func _on_start_screen_btn_pressed():
	get_tree().change_scene_to_file("res://scenes/screens/StartGameScreen/start_screen.tscn")# 
	StatsTracker.reset_stats()
func _ready():
	$AudioStreamPlayer.play()
	show_game_stats()
func show_game_stats():
	$"Stats Bar/VBoxContainer/BlueSpent".text = "BlueSpent " + str( StatsTracker.spent_money[0])
	$"Stats Bar/VBoxContainer/RedSpent".text = "RedSpent " +str( StatsTracker.spent_money[1])
	$"Stats Bar/VBoxContainer/BlueKilled".text = "BlueKilled " +str( StatsTracker.spent_money[0])
	$"Stats Bar/VBoxContainer/RedKilled".text ="RedKilled "  +str(   StatsTracker.spent_money[1])
	$"Stats Bar/VBoxContainer/BlueEarned".text ="BlueEarned "  +str(   StatsTracker.spent_money[0])
	$"Stats Bar/VBoxContainer/RedEarned".text ="RedEarned "  +str(   StatsTracker.spent_money[1])
	$"Stats Bar/VBoxContainer/GameLasted".text ="GameLasted "  + str( StatsTracker.turns_played)
