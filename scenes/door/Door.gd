tool
extends Area2D

export(int, 0,5) var door_number

onready var sprite = $Sprite
onready var collision = $CollisionShape2D

func _ready():
	sprite.region_rect.position.y = door_number * 8
