extends Node

var all_complete = false
signal room_completed
func _process(delta):
	for player in get_parent().player_manager.get_children():
		if not player.allow_move: return
	all_complete = true
	for node in get_children():
		if node.complete != true:
			all_complete = false
			break
	if all_complete:
		emit_signal("room_completed")
		set_process(false)
