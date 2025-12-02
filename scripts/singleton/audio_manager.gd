extends Node

const SFX_PLAYER = preload("uid://dldx6kg26r4xl")

@onready var player = SFX_PLAYER.instantiate()

func _ready() -> void:
	add_child(player)
	player.mute_all_audio()

func play_soundtrack(name_: String):
	player.unmute_particular_audio(name_)
	
func door_open():
	player.play_door_opened()
	
func door_close():
	player.play_door_closed()
	
func fade_in():
	player.scene_fade_in()
	
func fade_out():
	player.scene_fade_out()
	
func music_reset():
	player.reset_playheads()
