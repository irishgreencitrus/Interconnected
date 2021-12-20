extends Node

var musics = [
	"res://assets/music/HeatleyBros - HeatleyBros I - 09 8 Bit Onward.mp3",
	"res://assets/music/HeatleyBros - HeatleyBros III - 02 8 Bit Think.mp3",
	"res://assets/music/HeatleyBros - HeatleyBros III - 03 8 Bit Select.mp3",
]
const well_done_noise = preload("res://assets/SFX/well done.wav")

func start_new_music():
	$MusicPlayer.stream = load(musics[randi() % musics.size()])
	$MusicPlayer.play()
	
func play_completed_sound():
	$SFXPlayer.stream = well_done_noise
	$SFXPlayer.play()
func _ready():
	start_new_music()
	

func _on_MusicPlayer_finished():
	start_new_music()
