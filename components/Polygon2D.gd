extends Node2D
 
#
#func _ready():
#	visible = true
#	draw_range =  get_parent().action_range
##	position = get_parent().get_parent().position

func _proces():
	queue_redraw() 
func _draw():
	draw_circle(Vector2.ZERO, get_parent().action_range, Color(0.5,0.5,0.5,0.5))
	draw_arc(Vector2.ZERO, get_parent().action_range, 0,  PI*2, 200, Color("black"), 3)
 
