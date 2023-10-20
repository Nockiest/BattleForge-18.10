extends StateMachine
class_name BGStateMachine
 
func _on_canvas_next_turn_pressed() -> void:
	transition_to("NextTurnProcess")
