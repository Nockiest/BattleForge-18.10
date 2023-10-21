extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	queue_redraw()
	
func _draw() -> void:
	draw_arc(Vector2.ZERO, get_parent().action_range, 0,  PI*2, 200, Color(0,0,0,0.5), 3)
