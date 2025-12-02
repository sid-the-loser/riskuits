class_name SFXPlayer
extends Node3D

@export var title_theme: AudioStreamPlayer
@export var level_theme: AudioStreamPlayer
@export var wafune_theme: AudioStreamPlayer
@export var lotus_theme: AudioStreamPlayer
@export var ginna_theme: AudioStreamPlayer

@export var door_opened: AudioStreamPlayer
@export var door_closed: AudioStreamPlayer

@export var normal_volume: float = -10.0
@export var lowest_volume: float = -80.0

@export var scene_animator: AnimationPlayer

var faded_in_flag = false

func _ready() -> void:
	mute_all_audio()
	scene_fade_out()

func scene_fade_in():
	if not faded_in_flag:
		scene_animator.play("fade_in")
		faded_in_flag = true
	
func scene_fade_out():
	if faded_in_flag:
		scene_animator.play("fade_out")
		faded_in_flag = false

func unmute_particular_audio(name_: String):
	mute_all_audio()
	match name_:
		"title":
			title_theme.volume_db = normal_volume
			
		
		"level":
			level_theme.volume_db = normal_volume
		
		"wafune":
			wafune_theme.volume_db = normal_volume
		
		"lotus":
			lotus_theme.volume_db = normal_volume
		
		"ginna":
			ginna_theme.volume_db = normal_volume


func mute_all_audio():
	title_theme.volume_db = lowest_volume
	level_theme.volume_db = lowest_volume
	wafune_theme.volume_db = lowest_volume
	lotus_theme.volume_db = lowest_volume
	ginna_theme.volume_db = lowest_volume


func play_door_opened():
	door_opened.play()
	scene_fade_in()

func play_door_closed():
	door_closed.play()
	scene_fade_out()
