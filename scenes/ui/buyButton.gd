extends Button
signal buy_unit
 
@onready var UnitClass: PackedScene:
	set(value):
		UnitClass= value
		var instance = UnitClass.instantiate() as  Node2D
		%Cost.text = str(instance.cost)
		call_deferred_thread_group("change_buy_button_label")
		instance.queue_free()
@export var instanced_units_index = 0
@onready var battleground = get_tree().get_root().get_node("BattleGround")
#@export var connected_unit_scene = null
func change_buy_button_label():
	var instance = UnitClass.instantiate() as  Node2D
	%UnitTypeLabel.text = str(instance.unit_name)

func _ready():
	%TextureRect.set_size(Vector2(32,32))
	%TextureRect.size.x = 32
	%TextureRect.size.y = 32
	var style = StyleBoxFlat.new()
	style.bg_color = Color(1, 0, 0, 1)  # Change to your desired color
	set("custom_styles/normal", style)
	UnitClass = Globals.unit_packed_scenes_arr[instanced_units_index]
	call_deferred_thread_group("change_buy_button_label")
func _on_pressed(): 
	## bohuřžel nemůžžu psát proěné jako reference k jiným proměnným, což komplikuje kod
	$Pressed.play()
	if Globals.placed_unit != null:
		return
	var mock_unit = UnitClass.instantiate() as  Node2D
	mock_unit.is_newly_bought = true
#	var buy_area = battleground.get_node("BlueBuyArea")  if Globals.cur_player == "blue" else  battleground.get_node("RedBuyArea")
	if Globals.cur_player == "blue":
		if Globals.blue_player_money < mock_unit.cost:
			print("CANT BUY THE BLUE UNIT ", Globals.blue_player_money)
			return
		Globals.blue_player_money -= mock_unit.cost
##		buy_area._place_new_unit(mock_unit ,Globals.blue_player_money )
	else:
		if  Globals.red_player_money < mock_unit.cost:
			print("CANT BUY THE RED UNIT ", Globals.blue_player_money)
			return
		Globals.red_player_money -= mock_unit.cost
	mock_unit.color = Color(Globals.cur_player)
	mock_unit.add_to_team(Color(Globals.cur_player))
##		buy_area._place_new_unit(mock_unit ,  Globals.red_player_money )
	battleground.get_node("LivingUnits").add_child(mock_unit)





	# Get all the markers in the BuyArea
#	var markers = buyArea.get_children()
#
#	# Choose a random marker
#	var marker = markers[randi() % markers.size()]
#	for unit in living_units.get_children():
#		if unit.global_position == marker.global_position:
#			print("Position already occupied, not spawning new unit.")
#			return  # Exit the function without spawning a new unit
#	for unit in living_units.get_children():
#		var collision_area = unit.get_node("CollisionArea/CollisionShape2D")  # Replace with your actual node path
#		if collision_area.overlaps_area(marker):
#			print("Position already occupied, not spawning new unit.")
#			return
	# Instance a new unit
#	var unit = UnitClass.instantiate() as StaticBody2D
#	emit_signal("buy_unit", unit.cost)
#	# Set the unit's position to the marker's position
#	unit.global_position = marker.global_position
#	unit.add_to_team(Globals.cur_player)
#	# Add the unit to LivingUnits
#	living_units.add_child(unit)

#	buying_unit.emit()
#	# Instance the scene
#	print(basic_unit_scene)
#	var basic_unit = basic_unit_scene.instance()
#	# Add the instance to the scene tree
#	get_tree().get_root().add_child(basic_unit)
#	# Set the position of the instance to the mouse position
#	basic_unit.position = get_viewport().get_global_mouse_position()
