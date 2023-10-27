class_name SettingsSlider
extends Control

@export var attached_settings_variable = "blue_player_money" 
@export var augmented_dictionary_variable:String = "something"
@export var label_text:String = "Default Label"
@export var slider_range: Array = [0, 100] 
#@export var start_value:int = 10
func _on_h_slider_value_changed(value):
#	print(attached_settings_variable in Globals)
	print("CHANGING TO VALUE ", value )
	if attached_settings_variable in Globals:
		var a = Globals.get(attached_settings_variable)
		if a is Dictionary:
			Globals.get(attached_settings_variable)[augmented_dictionary_variable] = value
		else:
			a = value
			Globals.set(attached_settings_variable, a)
#			print(Globals.get(attached_settings_variable))
	$VBoxContainer/SliderValueLabel.text = str(round(value))

func _ready():
	$VBoxContainer/Label.text = label_text
	$VBoxContainer/HSlider.min_value = slider_range[0]
	$VBoxContainer/HSlider.max_value = slider_range[1]

	# Disconnect the signal temporarily
#	$VBoxContainer/HSlider.disconnect("value_changed",  _on_h_slider_value_changed )

	var a = Globals.get(attached_settings_variable)
#	print("GLOBALS SAVED VALUE ", a)

	if attached_settings_variable in Globals and not (a is Dictionary):
		print("ABLE TO SET VALUE ", Globals.get(attached_settings_variable), " ", attached_settings_variable)

	if attached_settings_variable in Globals:
		a = Globals.get(attached_settings_variable)
		if a is Dictionary:
#			print("SETTING TO ", Globals.get(attached_settings_variable)[augmented_dictionary_variable])
			$VBoxContainer/HSlider.value = Globals.get(attached_settings_variable)[augmented_dictionary_variable]
		else:
#			print("SETTING TO ", Globals.get(attached_settings_variable))
			$VBoxContainer/HSlider.value = Globals.get(attached_settings_variable)

	# Reconnect the signal
	$VBoxContainer/HSlider.connect("value_changed",  _on_h_slider_value_changed)

	$VBoxContainer/SliderValueLabel.text = str($VBoxContainer/HSlider.value)
 
