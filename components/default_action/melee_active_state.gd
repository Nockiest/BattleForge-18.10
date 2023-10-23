class_name MeleeActiveActionState
extends BaseActiveActionState


 
func play_slash_animation():
	print("PLAYING SLASH")
	var pos = Globals.hovered_unit.center  
	Utils.play_animation_at_position($SlashAnimation,"slash",pos) 

func attack():
	Globals.hovered_unit.get_node("HealthComponent").hit(1) 
	play_slash_animation()
	super.attack()
 

 
