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
@export var highlight_color:Color
@export var unsupportable_unit_types: Array = ["SupportUnit"]
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
	
func _process(_delta: float) -> void:
	if get_node("RangeOutline") == null:
		return
	
	if Globals.hovered_unit == owner:
		$RangeOutline.visible = true
	else:
		$RangeOutline.visible = false
 
 
func update_for_next_turn():
#	print("SUPPORT COMPONENT HAS UPDATING FOR NEXT TURN DISABLED FOR NOW")
	$StateMachine.provide_buffs()


func _on_area_entered(area):
	if area.name != "CollisionArea": 
		return  
	if not("color" in owner) : 
		print("SUPPORT ACTION OWNER DOEST HAVE COLOR")
		return
	if area.owner.color != owner.color:
		return
	if area.get_parent() == owner:
		return 2
	if not "color" in owner:
		return 6
	units_in_action_range.append(area.get_parent())
	return 7

 
func _on_area_exited(area):
	if area.name == "CollisionArea" and units_in_action_range.has(area.get_parent()):
		units_in_action_range.erase(area.get_parent()) 
 
 
