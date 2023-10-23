class_name Knight
extends MeleeUnit

func get_boost():
	print("KNIGHT SHOULD GET ONE MORE ACTION ", self,     )
	$movement_comp.remain_distance = $movement_comp.base_movement_range
	$HorseNeighing.play()
	action_component.remain_actions += 1
	var tween = get_tree().create_tween()
	tween.tween_property($ColorRect, "modulate", Color(1,1,1), 0.2)
	tween.tween_property($ColorRect, "modulate",   color, 0.2)
func _ready():
	super._ready()
	unit_name = "Knight"
 
