extends Node
 
var active = false
@export var sound_list:Array[AudioStream]
func play_random_sound():
	var random_index = randi_range(0, len(sound_list) -1) 
	$AudioStreamPlayer.stream =  sound_list[random_index]
	$AudioStreamPlayer.play()
	
func _process(_delta: float) -> void:
	if !$AudioStreamPlayer.playing and active:
		play_random_sound()
