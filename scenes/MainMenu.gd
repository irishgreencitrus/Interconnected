extends Control
func _ready():
	PauseMenu.get_node("PauseMenu").allow_pausing = false
func _on_Play_pressed():
	Transitions.horizontal_stripes(self, "res://scenes/levels/jam/Level1.tscn", 1.5, Color.black, 0.5)
func _on_LevelSelect_pressed():
	Transitions.horizontal_stripes(self, "res://scenes/LevelSelect.tscn", 1.5, Color.black, 0.5)


func _on_Options_pressed():
	Transitions.donut_eye(self,"res://scenes/Options.tscn",2.0, Color.black)
