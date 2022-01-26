tool
extends Area2D
const WORLD_LAYER  = 1 << 0
const PLAYER_LAYER = 1 << 1
const GOAL_LAYER = 1 << 2
const GATE_LAYER   = 1 << 3

var allow_move = true
var velocity := Vector2.ZERO
const TWEEN_SPEED = 7
export var player_number = 0

onready var sprite := get_node("PlayerSprite")
onready var tween := get_node("Tween")

func can_move_through_gate(dir: String) -> bool:
	var state := get_world_2d().get_direct_space_state()
	var gate_detection = state.intersect_point(
			global_position + Global.INPUTS[dir] * Global.TILE_SIZE,
			1,
			[],
			GATE_LAYER,
			true,
			true
	)
	if len(gate_detection) == 0: return true
	return gate_detection[0].collider.gate_number != player_number
func can_move(dir) -> bool:
	var physics_state := get_world_2d().get_direct_space_state()
	var brick_detection = physics_state.intersect_point(
			global_position + Global.INPUTS[dir] * Global.TILE_SIZE,
			1,
			[],
			WORLD_LAYER,
			true,
			true
	)
	if !can_move_through_gate(dir): return false
	if len(brick_detection) > 0:
		return false
	else:
		var player_detection = physics_state.intersect_point(
			global_position + Global.INPUTS[dir] * Global.TILE_SIZE,
			1,
			[],
			PLAYER_LAYER,
			true,
			true
		)
		if len(player_detection) > 0:
			return player_detection[0].collider.can_move(dir)
		else:
			return true
func _ready():
	sprite.region_rect.position.y = 8*player_number
	if !Engine.editor_hint:
		tween.connect("tween_all_completed",self,"_on_tween_complete")

func move_player(dir):
	var physics_state := get_world_2d().get_direct_space_state()
	var brick_detection = physics_state.intersect_point(
			global_position + Global.INPUTS[dir] * Global.TILE_SIZE,
			1,
			[],
			WORLD_LAYER,
			true,
			true
	)
	var player_detection = physics_state.intersect_point(
			global_position + Global.INPUTS[dir] * Global.TILE_SIZE,
			1,
			[],
			PLAYER_LAYER,
			true,
			true
	)
	
	if len(brick_detection) == 0:
		if can_move_through_gate(dir):
			if len(player_detection) == 0:
				move_tween(dir)
			else:
				if can_move(dir):
					move_tween(dir)
		else:
			if can_move_through_gate(dir):
				move_tween(dir)
func wait_move():
	allow_move = false
	yield(get_tree().create_timer(1.0/TWEEN_SPEED),"timeout")
	allow_move = true
func move_tween(dir):
	$"/root/MusicManager".play_move_sound()
	$CollisionShape2D.disabled = true
	allow_move = false
	tween.interpolate_property(self, "position",
		position, position + Global.INPUTS[dir] * Global.TILE_SIZE,
		1.0/TWEEN_SPEED, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
func _on_tween_complete():
	$CollisionShape2D.disabled = false
	allow_move = true
