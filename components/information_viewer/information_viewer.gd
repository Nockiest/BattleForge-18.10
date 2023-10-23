extends Control

@export var tracked_variables: Array[StringName]
@export var variable_images: Array[ImageTexture]= []


func _ready():
	for i  in len(tracked_variables):
		# Create a Label node for each variable
		var label = Label.new()
		label.text = str(owner.get(tracked_variables[i-1]))
		add_child(label)

		# Connect the label to update when the owner's variable changes
#		owner.connect("variable_changed", self, "_on_owner_variable_changed", [variable_name, label])
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print("PROCESS ", len(tracked_variables))
	for i  in len(tracked_variables)  :
		var owners_variable = owner.get(tracked_variables[i-1])
		var label = get_child(i-1)
		label.text =  str(owners_variable) 

