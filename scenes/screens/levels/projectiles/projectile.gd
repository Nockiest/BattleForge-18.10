extends Area2D
class_name  Projectile
@export var speed:int = 100
var direction 
var color:Color
var action_range 
var start_position  
var shooting_unit
# Called when the node enters the scene tree for the first time.
func _ready():
	start_position = position
	$ExplosionAnimation.hide()
	$ErrorAnimation.hide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += speed * delta * direction
	if position.distance_to(start_position) >= action_range:
		_play_explosion() 
		
func _on_area_entered(area):
	if area.get_parent() == shooting_unit:
		return false
	if area.get_parent().get_parent() is Forrest:
		_play_error()#_play_explosion()
	return true
func _play_explosion():
	# Only play the animation if it's not already playing
	if not $ExplosionAnimation.is_playing():
		$ExplosionAnimation.play("explosion")
		stop_movement()
		$Sprite2D.hide()
		$ExplosionAnimation.show()
		$Explosion.play()
		return true
	return false

func _play_error():
	$ErrorAnimation.show()
	$ErrorAnimation.play("error")
	$Sprite2D.hide()
	stop_movement()
func stop_movement():
	speed = 0
#	# Connect the animation_finished signal to a function that removes the parent node

func _on_damage_animation_animation_finished():
	queue_free()


func _on_error_animation_finished():
	queue_free()


