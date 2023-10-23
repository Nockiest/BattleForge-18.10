extends Area2D
signal buy_unit(cost)
var units_inside:Array = []
@export var team = "blue"
# 
 
func _ready():
	var color = Color(team)
	color.a = 0.3  # Set alpha to 0.5 for semi-transparency
	$ColorRect.modulate = color
func _process(_delta):
	if Globals.placed_unit != null:
		$ColorRect.show()
	else:
		$ColorRect.hide()

func _on_area_entered(area):
	if not(area is UnitsMainCollisionArea):
		return
	if not (area.get_parent() is BattleUnit):
		return
 
	units_inside.append(area.get_parent())
#	occuping_units[parent_color] 


func _on_area_exited(area):
	if not (area is UnitsMainCollisionArea):
		return
	if area.get_parent() not in units_inside:
		return
	units_inside.erase(area.get_parent())
#func _draw():
#	if Globals.placed_unit != null:
#		var points = [Vector2(-50, -50), Vector2(50, -50), Vector2(50, 50), Vector2(-50, 50)]
#		var color = Color("blue")
#		draw_colored_polygon(points, color)
		
#func _place_new_unit(unit, money   ):
#	var battleground = $".."
#	var living_units = battleground.get_node("LivingUnits")
#	var collision_shape =  get_node("CollisionShape2D")  # Replace with the actual path to your collision shape node
#
#	var square_size = collision_shape.shape.extents * 2
#	var point = Utils.get_random_point_in_square(square_size)
#	# Convert the local point to global coordinates
#	var global_point = collision_shape.to_global(point)
#
#	# Create a mock CollisionShape2D at the generated point
#	var mock_collision_shape = CollisionShape2D.new()
#	mock_collision_shape.shape = RectangleShape2D.new()
#	mock_collision_shape.shape.extents = square_size  / 2
#	# Offset the position by half of the shape's size to align the top-left corner with the point
##	print(global_point, mock_collision_shape.shape, mock_collision_shape.shape.extents )
#	mock_collision_shape.global_position = global_point #+ square_size / 2
#
#	# Add it to the scene temporarily for collision detection
#	add_child(mock_collision_shape)
#
#	# Check for collisions with other units
#	for entity in living_units.get_children():
#		var entity_size = entity.get_node("CollisionArea/CollisionShape2D").shape.extents * 2  # Replace with the actual path to your collision shape node
#		if entity.global_position.distance_to(mock_collision_shape.global_position) <= entity_size.length():
#			print("Position already occupied, not spawning new unit.")
#			# Remove the mock CollisionShape2D from the scene
#			remove_child(mock_collision_shape)
#			money += unit.cost
#			return  # Exit the function without spawning a new unit
#	# If no collisions, proceed with spawning the new unit
#	emit_signal("buy_unit", unit.cost)
#	# Set the unit's position to the marker's position
#	unit.global_position = global_point #+ square_size / 2
##	print_debug(unit_instance.global_position, " ", global_point, " ", square_size/2)
#	unit.add_to_team(Globals.cur_player)
#	# Add the unit to LivingUnits
#	living_units.add_child(unit)
#
##	print("SUBTRACTED MONEY ", player_money)
#	# Remove the mock CollisionShape2D from the scene
#	remove_child(mock_collision_shape)


 
		
#func _place_new_unit(unit):
#	var battleground = $".."
#	var living_units = battleground.get_node("LivingUnits")
#	var collision_shape =  get_node("CollisionShape2D")  # Replace with the actual path to your collision shape node
#
#	var square_size = collision_shape.shape.extents * 2
#	var point = Utils.get_random_point_in_square(square_size)
#	# Convert the local point to global coordinates
#	var global_point = collision_shape.to_global(point)
#
#	# Create a mock CollisionShape2D at the generated point
#	var mock_collision_shape = CollisionShape2D.new()
#	mock_collision_shape.shape = RectangleShape2D.new()
#	mock_collision_shape.shape.extents = square_size / 2
#	mock_collision_shape.global_position = global_point
#
#	# Add it to the scene temporarily for collision detection
#	self.add_child(mock_collision_shape)
#
#	# Check for collisions with other units
#	for entity in living_units.get_children():
#		if entity.global_position.distance_to(mock_collision_shape.global_position) <= square_size.length():
#			print("Position already occupied, not spawning new unit.")
#			# Remove the mock CollisionShape2D from the scene
#			self.remove_child(mock_collision_shape)
#			return  # Exit the function without spawning a new unit
#
#	# If no collisions, proceed with spawning the new unit
#	var unit_instance = unit.instantiate() as StaticBody2D
#	emit_signal("buy_unit", unit_instance.cost)
#	# Set the unit's position to the marker's position
#	unit_instance.global_position = global_point
#	print_debug(unit_instance.global_position)
#	unit_instance.add_to_team(Globals.cur_player)
#	# Add the unit to LivingUnits
#	living_units.add_child(unit_instance)
#
#	# Remove the mock CollisionShape2D from the scene
#	self.remove_child(mock_collision_shape)
#print("x",global_point)
#	print_debug(collision_shape.get_global_transform())
