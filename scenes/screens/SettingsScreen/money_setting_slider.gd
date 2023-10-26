class_name MoneySettingSlider
extends SettingsSlider


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
#	var saved_value
#	if $VBoxContainer/HSlider.value != 100:
#		saved_value =$VBoxContainer/HSlider.value 
	super._ready()
	_on_h_slider_value_changed(100)
	$VBoxContainer/HSlider.value = 100
 
