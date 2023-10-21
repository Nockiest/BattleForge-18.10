class_name ObserveStateChoosing
extends SupportStateChoosing


func check_can_support() -> bool:
	if Globals.hovered_unit is MeleeUnit:
		#support_error.emit( )
		return false
	return super.check_can_support()
#
