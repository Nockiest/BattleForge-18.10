extends Control
 
var team:String  
var prev_units = null
var sorted_units:Dictionary = {}

func _ready():
	var index = get_index()
	Globals.connect("player_money_changed", update_tender )
	if index == 0:
		$ColorRect.color = Color("red")
		team = "red" 
	elif index == 1:
		$ColorRect.color = Color("blue")
		team = "blue"
	else:
		print("This node is not the first or second child of its parent.")
 
 
func sort_units(units):
	sorted_units = {}
	for unit in units:
		var unit_type = unit.unit_name  # get_class()
		if sorted_units == null:
			sorted_units[unit_type] = 1
		elif unit_type in sorted_units:
			sorted_units[unit_type] += 1
		else:
			sorted_units[unit_type] = 1

func update_tender():
	var same_color_units = get_tree().get_nodes_in_group(str(Color(team)))
	var current_money =  Globals.red_player_money if team == "red" else   Globals.blue_player_money
	$ColorRect/VScrollBar/VBoxContainer/Money/Label.text = str(current_money)
 
	if same_color_units:
		sort_units(same_color_units)
 
	var vbox = $ColorRect/VScrollBar/VBoxContainer
	for child in vbox.get_children():
	# If the child's name begins with "UnitCount", delete it
		if not child.name.begins_with("Money"):
			child.queue_free()

# For each count in unit_counts, create a new Label and add it to the VBoxContainer
	for key in sorted_units.keys():
		var label = Label.new()
		label.name = "UnitCount" + key
		label.text = key + ": " + str(sorted_units[key])
		label.mouse_filter = Control.MOUSE_FILTER_IGNORE
		vbox.add_child(label)
 
#	$ColorRect/VScrollBar/VBoxContainer/Money/Label.text = str(current_money)
#	if team == "blue":  
#		$ColorRect/VScrollBar/VBoxContainer/Money/Label.text = str(Globals.blue_player_money)
#	elif team =="red":
#		$ColorRect/VScrollBar/VBoxContainer/Money/Label.text = str(Globals.red_player_money)
#	else:
#		print_debug("something wrong with rendering money ", team)
 
