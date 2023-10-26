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
#	print("PROJECTILE SHOT")
	start_position = global_position
	$ExplosionAnimation.hide()
	$ErrorAnimation.hide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$terrain_type_finder.find_current_overlapping_terrain() 
	global_position += speed * delta * direction
	if global_position.distance_to(start_position) >= action_range:
		_play_explosion() 
		
func _on_area_entered(area):
#	print( global_position.distance_to(start_position) , shooting_unit.size)
	if global_position.distance_to(start_position) <  max(shooting_unit.size.x, shooting_unit.size.y)/2:
		return false
	if area.get_parent() == shooting_unit:
		return false
	if area.get_parent().get_parent() is Forrest and $terrain_type_finder.top_most_terrain_type != "road":
		_play_error() 
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


