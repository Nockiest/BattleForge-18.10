extends SupportAction
class_name RessuplyAction

func _ready():
	buffed_variable = "ammo"
	increase_ammount = 1
func _on_area_entered(area):
	print("AREA ENTERED",area.get_parent(),area.get_parent() is RangedUnit )
	if not(area.get_parent() is RangedUnit):
		return
	super._on_area_entered(area)

##	constant_buff = false
##	color = Color(0.5,0.5,0.5)
#	$AnimatedSprite2D.hide()  # Hide the AnimatedSprite node on ready
#	super._ready()
#func _on_next_turn():
#	print("NEXT TURN")
#
#func provide_buffs():
#	super.provide_buffs()
#	if supported_entity:
#		Utils.play_animation_at_position($AnimatedSprite2D,"resupply_animation", supported_entity.global_position) 

 
