class_name Observer
extends SupportUnit

func _ready():
	action_component =$ActionComponent/ObserveAction  
	super._ready()
	unit_name = "observer"
 


func _on_observe_action_support_error( ):
	Utils.play_animation_at_position($ErrorAnimation, "error", Globals.hovered_unit.get_node("Center").global_position)

 
