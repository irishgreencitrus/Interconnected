extends Control
var paused = false
var allow_pausing = false
func _ready():
	hide()
func _unhandled_input(event):
	if !allow_pausing: return
	if event is InputEventKey:
		if event.pressed:
			if event.scancode == KEY_ESCAPE:
				paused = !paused
				if paused:
					show()
					AudioServer.set_bus_mute(0,true)
					get_tree().paused = true
				else:
					hide()
					AudioServer.set_bus_mute(0,false)
					get_tree().paused = false
