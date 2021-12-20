extends Area2D


export var goal_number = 0
var complete = false
func _ready():
	$Sprite.region_rect.position.y = 8*goal_number

func _on_area_entered(area):
	if area.is_in_group("Player"):
		if area.player_number == goal_number:
			complete = true
			print(complete)


func _on_area_left(area):
	if area.is_in_group("Player"):
		if area.player_number == goal_number:
			complete = false
