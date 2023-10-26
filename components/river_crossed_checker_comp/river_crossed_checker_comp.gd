extends Node2D

var last_frame_position = global_position
signal crossed_river()
# Called when the node enters the scene tree for the first time.
 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if last_frame_position == global_position:
		return
#	print("PROCESSING")
	check_river_crossed()
	last_frame_position = global_position

func check_river_crossed():
	$RayCast2D.global_position = global_position
	$RayCast2D.target_position = to_local(last_frame_position) #to_local(global_position)
	$RayCast2D.force_raycast_update()
#	print( $RayCast2D.get_colliding_areas())
#	print("POSsITIONS", $RayCast2D.global_position,  global_position,  $RayCast2D.is_colliding())
	if $RayCast2D.is_colliding():
		print("ENTITY CROSSED A RIVER")
		crossed_river.emit()
		
