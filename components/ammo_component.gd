extends Node2D
signal ammo_changed()
 
var max_ammo: int
@onready var ammo:int = max_ammo/2:
	get:
		return ammo
	set(value):
		var prev_ammo = ammo
		print("NEW VALUE", value, " ",prev_ammo)
		ammo = min(value, max_ammo)
		ammo_changed.emit(ammo)
		if prev_ammo > ammo:
			Utils.play_animation_at_position( $AmmoChangeAnimation, "decrease",  global_position )
		elif  prev_ammo < ammo:
			Utils.play_animation_at_position( $AmmoChangeAnimation, "increase",  global_position )
			$AmmogGainedPlayer.play()
		print("CHANGING VALUE OF AMMO ", ammo)
 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
