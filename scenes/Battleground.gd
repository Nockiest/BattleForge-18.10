extends Node2D
 
var loaded = false
#var teams = ["red", "blue"]
 
@onready var players = get_tree().get_nodes_in_group("players")
 
 
func _ready():
	pass
 
