class_name Knight
extends MeleeUnit

func get_boost():
#	$movement_comp.remain_movement += 1
	print("KNIGHT SHOULD GET ONE MORE ACTION ", self,     )
	$movement_comp.remain_distance = $movement_comp.base_action_range 
#	print("KNIGHT IS GETTING ONE MORE MOVE ", self, " ",   )
	
func _ready():
	super._ready()
	unit_name = "Knight"
 
