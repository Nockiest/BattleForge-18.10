class_name Medic
extends SupportUnit

func _ready():
	action_component = $ActionComponent/HealingAction  
	super._ready()
 
	unit_name = "medic"
#	disconnecct(_on_area_2d_area_emtered)
