extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready():
 

	value = get_parent().max_hp
	max_value = get_parent().max_hp


#func _on_hp_changed(hp, _prev_hp ):
#	value = hp


func _on_health_component_hp_changed(hp, _prev_hp):
	value = hp
