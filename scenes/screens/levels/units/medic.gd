class_name Medic
extends SupportUnit

func _ready():
 
	super._ready()
	action_component = $ActionComponent/HealingAction  
	unit_name = "medic"
#	disconnecct(_on_area_2d_area_emtered)
