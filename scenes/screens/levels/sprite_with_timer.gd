extends Sprite2D

# Assuming $Timer is the path to your Timer node
 
func _ready():
	print("INSTANTIATED")
	# Show the Sprite node
	show()
	# Start the timer
	$Timer.start()

func _on_timer_timeout():
	# Hide the Sprite node when the timer times out
	queue_free()
