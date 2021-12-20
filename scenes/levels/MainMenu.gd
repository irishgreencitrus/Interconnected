extends Control




func _on_Play_pressed():
	Transitions.horizontal_stripes(self, "res://scenes/levels/Level1.tscn", 1.5, Color.black, 0.5)
