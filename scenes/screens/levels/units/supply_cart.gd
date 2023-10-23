class_name SupplyCart
extends SupportUnit


func _ready():
	action_component = $ActionComponent/ResupplyAction  
	super._ready()
	unit_name = "supply_cart"
 
