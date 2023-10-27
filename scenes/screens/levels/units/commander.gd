extends MeleeUnit
class_name Commander
signal commander_killed(color)
  
func _ready():
	super._ready()
	unit_name = "commander"
func _on_health_component_hp_changed(hp, max_hp):
	super._on_health_component_hp_changed(hp, max_hp)
	if hp <= 0:
		print("PLAYER WILL LOSE THE GAME AFTER I CATCH THIS EMITTED SIGNAL")
		commander_killed.emit(color)#	emit_signal("commander_killed", color)
		Globals.end_game(Globals.color_names[color])



	# Connect the signal to the grandparent's method
#	connect("commander_killed",  Globals._end_game)
