class_name  SupportAction
extends DefaultAttackComponent
 
var supported_entity
var buffed_variable = "action_range"
var increase_ammount = 200
#var color = Color(1, 0.75, 0.8) 
var area_support = false

enum SupportStates {
	Idle,
	ProvidingSupport
}
var current_support_state = SupportStates.Idle

func start_supporting(new_supported_entity):
	current_support_state = SupportStates.ProvidingSupport
	supported_entity = new_supported_entity
	print("CUR STATE ",current_support_state, )
## this is independent of the parent exit action function
func stop_supporting():
	print("STOPPED SUPPORTING")
#	exit_action_state()
	current_support_state = SupportStates.Idle
	supported_entity = null
#	unhighlight_units_in_range()
 
func _process(_delta):
	super._process(_delta)
	if current_support_state == SupportStates.ProvidingSupport:
		draw_line_to_supported_entity()
 
func _ready():
	super._ready()
 
func check_can_support():
	if Globals.hovered_unit == owner or Globals.hovered_unit == null or Globals.hovered_unit == supported_entity:
		return false
	if Globals.hovered_unit.color != owner.color:
		print(owner," 2")
		return false
	if Globals.action_taking_unit  != owner:
		print(owner," 3")
		return false
	if  Utils.get_collision_shape_center( owner.get_node("CollisionArea") ).distance_to(Utils.get_collision_shape_center(owner.get_node("CollisionArea") )) > action_range:
		print(owner," 5")
		return false
	return true

func choose_supported():
#	print("CHOOSING SUPPORTED", check_can_support())
	if not check_can_support():
		stop_supporting() 
		exit_action_state()
		return
	print("STARTING TO SUPPORT")
	start_supporting(Globals.hovered_unit)
#	supported_entity = Globals.hovered_unit
	exit_action_state()
	return "SUCCESS"
 
 
## currently when i want to provide a buff on the enemy turn, it wouldnt work
func provide_buffs():
	if area_support:
		return
	if owner.color  != Color(Globals.cur_player):
		return
	if supported_entity:
		var entity_to_buff = supported_entity if buffed_variable in supported_entity else Utils.find_child_with_variable(supported_entity, buffed_variable)
		print(entity_to_buff, "ENTITY TO BUFF")
		if entity_to_buff and entity_to_buff.get(buffed_variable) != null:
			entity_to_buff.set(buffed_variable, entity_to_buff.get(buffed_variable) + increase_ammount)
 
 
func update_for_next_turn():
	provide_buffs()


func draw_line_to_supported_entity():
	$SupportConnnection.clear_points()  # Clear any existing points
	if supported_entity != null:
		# Convert global positions to Line2D's local space
		var local_start =to_local(owner.get_node("Center").global_position ) # $SupportConnnection.to_local(owner.center)
		var local_end = to_local( supported_entity.get_node("Center").global_position    ) #$SupportConnnection.to_local( supported_entity.center  )  
		$SupportConnnection.add_point(local_start)  # Add the parent's position as a point
		$SupportConnnection.add_point(local_end )  # Add the supported entity's position as a point
		# Calculate the distance between the start and end points
		if not  get_overlapping_areas().has(supported_entity.get_node("CollisionArea")):
			stop_supporting()
 
 
		var distance = local_start.distance_to(local_end)
		if distance > action_range:
			stop_supporting()
			return
 
 
func _on_area_entered(area):
	if area.name != "CollisionArea": 
		return  
	if not("color" in owner) :#not( owner.has("color") ):
		print("SUPPORT ACTION OWNER DOEST HAVE COLOR")
		return
	if area.owner.color != owner.color:
		return
	if str(super._on_area_entered(area)) == "SAME COLOR":
		print("observer area entered",area.get_parent(),area.owner.color ,owner.color,  get_parent( ))
		if area.owner.color != owner.color:
			return
		units_in_action_range.append(area.get_parent())
 
 

 
