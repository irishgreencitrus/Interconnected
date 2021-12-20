extends Area2D

var velocity := Vector2.ZERO
const TWEEN_SPEED = 7
export var player_number = 0
onready var raycast := get_node("MovementRay")
onready var sprite := get_node("PlayerSprite")
onready var tween := get_node("Tween")
func _ready():
	sprite.region_rect.position.y = 8*player_number
	tween.connect("tween_all_completed",self,"_on_tween_complete")
	#position = position.snapped(Vector2.ONE * Global.TILE_SIZE)
	#position += Vector2.ONE * Global.TILE_SIZE/2
func _unhandled_input(event):
	if tween.is_active():
		return
	for dir in Global.INPUTS.keys():
		if event.is_action_pressed(dir):
			move_player(dir)

func move_player(dir):
	if dir == "player_left":
		sprite.flip_h = true
	elif dir == "player_right":
		sprite.flip_h = false
	raycast.cast_to = Global.INPUTS[dir] * Global.TILE_SIZE
	raycast.force_raycast_update()
	if !raycast.is_colliding():
		move_tween(dir)
func move_tween(dir):
	$CollisionShape2D.disabled = true
	tween.interpolate_property(self, "position",
		position, position + Global.INPUTS[dir] * Global.TILE_SIZE,
		1.0/TWEEN_SPEED, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
func _on_tween_complete():
	$CollisionShape2D.disabled = false
