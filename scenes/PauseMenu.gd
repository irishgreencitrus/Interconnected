extends Control
var paused = false
var allow_pausing = false
func _ready():
	hide()
func _while_paused(delta):
	if !allow_pausing:
		_unpause()
		return
	if Input.is_action_just_pressed("restart"):
		_unpause()
		get_tree().reload_current_scene()
	elif Input.is_action_just_pressed("mainmenu"):
		_unpause()
		get_tree().change_scene("res://scenes/MainMenu.tscn")
func _pause():
	paused = true
	show()
	AudioServer.set_bus_mute(0,true)
	get_tree().paused = true

func _unpause():
	paused = false
	hide()
	AudioServer.set_bus_mute(0,false)
	get_tree().paused = false

func _input(event):
	if !allow_pausing: return
	if Input.is_action_just_pressed("pause"):
		paused = !paused
		if paused:
			_pause()
		else:
			_unpause()

func _process(delta):
	if paused: _while_paused(delta)
