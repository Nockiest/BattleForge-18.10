extends Control

func _ready() -> void:
	$tutorial_screen_page_1.connect("go_back_clicked", _go_back_from_tutorial)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), %HSlider.value-5 )
#	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), log_volume_db)
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


 

func _on_sfx_sound_value_changed(value: float) -> void:
	var bus_idx = AudioServer.get_bus_index("Master")
	print("SETTING VALUE ", value)
	if value > %HSlider.min_value:
		AudioServer.set_bus_mute(bus_idx,false)
		if value > 70:
			AudioServer.set_bus_volume_db(bus_idx,70+(value-5)/70)
		else:
			AudioServer.set_bus_volume_db(bus_idx,value-5)
	else:
		AudioServer.set_bus_mute(bus_idx,true)


func _on_bg_sound_slider_value_changed(value: float) -> void:
	var bus_idx = AudioServer.get_bus_index("BgMusic")
	print("SETTING VALUE ", value)
	if value > %BgSoundSlider.min_value:
		AudioServer.set_bus_mute(bus_idx,false)
		AudioServer.set_bus_volume_db(bus_idx,value)
	else:
		AudioServer.set_bus_mute(bus_idx,true)

