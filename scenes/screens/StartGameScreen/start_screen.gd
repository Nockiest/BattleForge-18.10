extends Control

func _ready() -> void:
	$tutorial_screen_page_1.connect("go_back_clicked", _go_back_from_tutorial)

func _on_start_game_btn_pressed():
		get_tree().change_scene_to_file("res://scenes/Battleground.tscn") 


func _on_settings_btn_pressed():
	show_and_hide($SettingsScreen, $MainButtons)
 
func show_and_hide(node_to_show, node_to_hide):
	node_to_show.show()
	node_to_hide.hide()


func _on_back_to_start_screen_btn_button_up():
	show_and_hide($MainButtons, $SettingsScreen)


func _on_exit_btn_button_up():
	get_tree().quit()
	
#func _ready() -> void:
#	$AudioStreamPlayer.play()
#
func _process(_delta: float) -> void:
	$random_music_player.active = true


func _on_tutorial_btn_pressed() -> void:
	show_and_hide($tutorial_screen_page_1,$MainButtons,   )


func _go_back_from_tutorial() -> void:
	show_and_hide( $MainButtons,$tutorial_screen_page_1)


 
 
