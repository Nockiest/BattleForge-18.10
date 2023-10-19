extends Node

#var movement_sounds = [preload("res://music/grass_step.wav"), preload("res://music/gravel_step.wav")]
var active = false
@export var sound_list:Array[AudioStream]
func play_random_sound():
	var random_index = randi_range(0, len(sound_list) -1) 
	#var random_sound = sound_list[random_index]
	$AudioStreamPlayer.stream =  sound_list[random_index]
	$AudioStreamPlayer.play()
	
func _process(_delta: float) -> void:
	if !$AudioStreamPlayer.playing and active:
		print("PlAYING RANDOM SOUND")
		play_random_sound()
