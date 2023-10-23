extends Area2D

var dispense_range = 300

# Called when the node enters the scene tree for the first time.
func _ready():
	var uis = get_tree().get_nodes_in_group("ui")
	for ui in uis:
		if ui is Canvas:
			ui.connect("next_turn_pressed",$ResupplyAction.provide_buffs)
func _draw():
	if Globals.hovered_structure == self:
		var fill_color = Color(0.1,0.1,0.1)
		draw_circle(position, dispense_range, fill_color)
		# Set the collision shape to match the drawn circle.
		$SupplyRangeArea/CollisionShape2D.shape = CircleShape2D.new()
		$SupplyRangeArea/CollisionShape2D.shape.radius = dispense_range
		$SupplyRangeArea/CollisionShape2D.global_position = position
# Called every frame. 'delta' is the elapsed time since the previous frame.

 
func _process(delta):
	pass


func _on_mouse_entered():
	Globals.hovered_structure = self


func _on_mouse_exited():
	if Globals.hovered_structure == self:
		Globals.hovered_structure = null
