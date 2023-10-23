extends SupportStateProviding


# Called when the node enters the scene tree for the first time.
func provide_buffs():
	if super.provide_buffs() != false:
		supported_entity.action_component.get_node("ammo_component").ammo += 1
