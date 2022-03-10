extends Control

func _ready():
	$VBoxContainer/ScreenFX.pressed = $"/root/GlobalEnvironment".environment.glow_enabled
	$VBoxContainer/Music.pressed = not AudioServer.is_bus_mute(2)
	$VBoxContainer/SFX.pressed = not AudioServer.is_bus_mute(1)

func _on_Button_pressed():
	Transitions.donut_eye(self,"res://scenes/MainMenu.tscn",2.0, Color.black)
	


func _on_Music_toggled(button_pressed):
	AudioServer.set_bus_mute(2,not button_pressed)


func _on_SFX_toggled(button_pressed):
	AudioServer.set_bus_mute(1,not button_pressed)


func _on_ScreenFX_toggled(button_pressed):
	$"/root/GlobalEnvironment".environment.glow_enabled = button_pressed
