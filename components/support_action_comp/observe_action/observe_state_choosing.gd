class_name ObserveStateChoosing
extends SupportStateChoosing


func check_can_support() -> bool:
	if not(Globals.hovered_unit is RangedUnit):
		#support_error.emit( )
		return false
	return super.check_can_support()
#

