extends CanvasLayer

func _on_start_screen_btn_pressed():
	get_tree().change_scene_to_file("res://scenes/screens/StartGameScreen/start_screen.tscn")# 

func _ready():
	$AudioStreamPlayer.play()
