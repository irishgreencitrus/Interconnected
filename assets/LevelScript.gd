extends Node2D


export var goal_manager_path : NodePath
export var player_manager_path : NodePath
export var next_scene : String
onready var player_manager = get_node(player_manager_path)
onready var goal_manager = get_node(goal_manager_path)
var process_input = true
func _ready():
	PauseMenu.get_node("PauseMenu").allow_pausing = true
	goal_manager.connect("room_completed",self,"_on_level_complete")
	assert(next_scene != "")
func _physics_process(delta):
	if not process_input: return
	if get_tree().paused: return
	for player in player_manager.get_children():
		if not player.allow_move:
			return
	for dir in Global.INPUTS.keys():
		if Input.is_action_just_pressed(dir):
			for player in player_manager.get_children():
				player.move_player(dir)
func _on_level_complete():
	process_input = false
	PauseMenu.get_node("PauseMenu").allow_pausing = false
	$AnimationPlayer.play("Level Complete")
	$"/root/MusicManager".play_completed_sound()
	yield(get_tree().create_timer(3.0),"timeout")
	Transitions.dual_circles(self,next_scene,1.5,Color.black)
	
