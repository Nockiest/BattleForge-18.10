extends Control
signal go_back_clicked

 
func _on_back_to_start_screen_btn_2_button_up() -> void:
	go_back_clicked.emit()


func _on_unit_types_url_btn_pressed() -> void:
	OS.shell_open("https://medium.com/@andwebdev/gamedev-diary-units-and-their-abillities-da53dda4bbdb")
