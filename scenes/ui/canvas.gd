extends CanvasLayer
class_name Canvas
signal next_turn_pressed
signal player_gave_up

func on_cur_player_has_been_changed():
	update_label()
	
func update_label():
	$Ui/Label.text = "Cur_player: " + str(Globals.cur_player)
	$Ui/Label.modulate = Color(Globals.cur_player)
 
func update_color(ammount:int, label: Label,   color:Color) -> void:
	if ammount > 0:
		label.modulate = color
	else:
		label.modulate = Color("red")

func _ready():
	update_label()
	Globals.connect("cur_player_has_been_changed", on_cur_player_has_been_changed) 
 

func sort_by_instance(a, b):
	return a.get_class() < b.get_class()

func _on_give_up_btn_up(): 	 
	player_gave_up.emit()
	Globals.end_game(Globals.cur_player)
 


func _on_next_turn_btn_button_up():
	next_turn_pressed.emit()
	StatsTracker.increase_stat_by("turns_played", null, 1)

func _on_check_button_pressed():
	print("PRESSED")
	for unit in get_tree().get_nodes_in_group("living_units"):
		unit.get_node("ColorRect").visible = !unit.get_node("ColorRect").visible
		unit.get_node("Sprite2D").visible = !unit.get_node("Sprite2D").visible


func _on_check_button_2_pressed():
	for unit in get_tree().get_nodes_in_group("living_units"):
		unit.action_component.get_node("AttackRangeShape").visible = !unit.action_component.get_node("AttackRangeShape").visible


 

func _on_check_button_3_toggled(button_pressed):
	$Ui.visible = !$Ui.visible 


func _on_check_button_button_up():
	print("PRESSED")
