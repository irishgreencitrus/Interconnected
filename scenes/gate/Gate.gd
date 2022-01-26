tool
extends Area2D

export(int, 0,5) var gate_number

onready var sprite = $Sprite
onready var collision = $CollisionShape2D

func _ready():
	sprite.region_rect.position.y = gate_number * 8
