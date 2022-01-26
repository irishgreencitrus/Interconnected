extends Control

export(String, DIR) var level_location
export(NodePath) var grid_path
export(String, FILE, "*.tscn") var before_scene
export(String, FILE, "*.tscn") var next_scene
onready var grid = get_node(grid_path)
onready var before_button =  $BeforeButton
onready var next_button   =  $AfterButton
var avail_levels = []
func _ready():
	if before_scene == "": before_button.hide()
	if next_scene == "":   next_button.hide()
	PauseMenu.get_node("PauseMenu").allow_pausing = false
	var dir = Directory.new()
	if dir.open(level_location) == OK:
		dir.list_dir_begin(true)
		var file_name = dir.get_next()
		while file_name != "":
			avail_levels.append(file_name)
			file_name = dir.get_next()
		dir.list_dir_end()
		print("Done")
	else:
		print("An Error Occurred.")
		return
	for i in range(avail_levels.size()):
		var level_button : Button = Button.new()
		level_button.name = str(i)
		level_button.text = str(i + 1)
		level_button.size_flags_horizontal = SIZE_EXPAND | SIZE_FILL
		level_button.size_flags_vertical = SIZE_EXPAND | SIZE_FILL
		grid.add_child(level_button)
func _process(delta):
	if before_button.pressed: Transitions.donut_eye(self,before_scene,2,Color.black)
	if next_button.pressed:   Transitions.donut_eye(self,next_scene,2,Color.black)
	for button in grid.get_children():
		if button.pressed:
			var level_to_load = level_location + "/" + avail_levels[int(button.name)]
			Transitions.donut_eye(self,level_to_load,2,Color.black)
