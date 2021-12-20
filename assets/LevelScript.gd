extends Node2D


export var goal_manager_path : NodePath
export var player_manager_path : NodePath
export var next_scene : String
onready var player_manager = get_node(player_manager_path)
onready var goal_manager = get_node(goal_manager_path)

func _ready():
	goal_manager.connect("room_completed",self,"_on_level_complete")
	assert(next_scene != "")

func _on_level_complete():
	for player in player_manager.get_children():
		set_process_input(false)
	print("DONE")
	$AnimationPlayer.play("Level Complete")
	$"/root/MusicManager".play_completed_sound()
	yield(get_tree().create_timer(3.0),"timeout")
	Transitions.dual_circles(self,next_scene,1.5,Color.black)
	
