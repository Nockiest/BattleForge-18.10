class_name  SupportAction
extends Area2D
 
var supported_entity
var buffed_variable = "action_range"
var increase_ammount = 200
@export var base_actions = 1
var remain_actions = base_actions
@export var area_support = false
@export var support_line_color:Color
var units_in_action_range:Array= []
@export var process_action_sound:Node
var reachable_units:Array = []
var base_action_range:int = 100:
	set(value):
		base_action_range = value
		action_range =floor( base_action_range * Utils.sum_dict_values(aciton_range_modifiers))
var action_range:int = base_action_range:
	get:
		return action_range
	set(value):
		action_range = value
		units_in_action_range = []
		$AttackRangeShape.shape = CircleShape2D.new()
		$AttackRangeShape.shape.radius = action_range
		$AttackRangeCircle.queue_redraw() 
 
var aciton_range_modifiers = {
	"base_modifier": 1,
	"observer": 0
	}
func _ready():
	pass
	
func _process(delta: float) -> void:
	if get_node("RangeOutline") == null:
		return
	
	if Globals.hovered_unit == owner:
		$RangeOutline.visible = true
	else:
		$RangeOutline.visible = false
 
 
func update_for_next_turn():
	print("SUPPORT COMPONENT HAS UPDATING FOR NEXT TURN DISABLED FOR NOW")
 
func provide_buffs():
	$StateMachine.provide_buffs()
#func _on_area_entered(area):
#	if area.name != "CollisionArea": 
#		return  
#	if not("color" in owner) :#not( owner.has("color") ):
#		print("SUPPORT ACTION OWNER DOEST HAVE COLOR")
#		return
#	if area.owner.color != owner.color:
#		return
#	if str(super._on_area_entered(area)) == "SAME COLOR":
#		print("observer area entered",area.get_parent(),area.owner.color ,owner.color,  get_parent( ))
#		if area.owner.color != owner.color:
#			return
#		units_in_action_range.append(area.get_parent())
#
 

 
