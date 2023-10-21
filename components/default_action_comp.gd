extends Area2D
class_name DefaultAttackComponent
signal remain_actions_updated(new_attacks)
signal entering_action_state()
signal exiting_action_state()
var base_actions:int = 1
var remain_actions: int = base_actions:
	set(new_attacks):
		remain_actions = new_attacks
		emit_signal("remain_actions_updated", remain_actions)
var units_in_action_range:Array= []
@export var process_action_sound:AudioStream
var reachable_units:Array = []
var projectile_size:int = 0
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
 
@export var highlight_color = "white"
 
 
func  update_for_next_turn():
	remain_actions = base_actions
	
#	unhighlight_units_in_range()

func _process(delta: float) -> void:
	if get_node("RangeOutline") == null:
		return
	
	if Globals.hovered_unit == owner:
		$RangeOutline.visible = true
	else:
		$RangeOutline.visible = false
 
func _on_area_entered(area):
 
	if area.get_parent() == owner:
#		print_debug("FAIL")
		return 2
	if area.name != "CollisionArea": 
#		print_debug("isnt unit", area.name)
		return 3
	if  area.get_parent().color == null:
#		print_debug("FAIL")
		return 5
	if not "color" in owner:
		return 6
	if area.get_parent().color == owner.color:
#		print_debug("ISNT SAME COLOR",area.get_parent().color , owner.color )
		return "SAME COLOR"
	units_in_action_range.append(area.get_parent())
	return 7

 
func _on_area_exited(area):
	if area.name == "CollisionArea" and units_in_action_range.has(area.get_parent()):
		units_in_action_range.erase(area.get_parent()) 
 
func _ready() -> void:
	pass
 
