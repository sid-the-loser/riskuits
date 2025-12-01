class_name SFXPlayer
extends Node3D

@export var title_theme: AudioStreamPlayer
@export var level_theme: AudioStreamPlayer
@export var wafune_theme: AudioStreamPlayer
@export var lotus_theme: AudioStreamPlayer
@export var ginna_theme: AudioStreamPlayer

@export var normal_volume: float = -10.0
@export var lowest_volume: float = -80.0

func _ready() -> void:
	mute_all_audio()

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
