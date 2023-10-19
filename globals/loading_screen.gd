extends CanvasLayer

var timer

func render_loading_screen():
	$AnimationPlayer.play_backwards("loading_animation")
	visible = true
	if not timer:
		timer = Timer.new()
		add_child(timer)
		timer.wait_time = 0.5
		timer.one_shot = true
		timer.connect("timeout", _on_timer_timeout)
	timer.start()

func _on_timer_timeout():
	visible = false


## Called when the node enters the scene tree for the first time.
#func _ready():
#	render_loading_screen()
#
