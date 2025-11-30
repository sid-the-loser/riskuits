extends Node3D


const HALLWAY = preload("uid://d0jasc8dyycal")

@onready var animation_player: AnimationPlayer = $Camera3D/AnimationPlayer
@onready var animation_player_gals: AnimationPlayer = $Control/TextureRect3/AnimationPlayer

func _ready():
	animation_player.play("TitleScreenCameraMove")
	animation_player_gals.play("TitleGals")
	
func _on_play_button_button_down() -> void:
	GameManager.tutorial_flag = true
	get_tree().change_scene_to_packed(HALLWAY)


func _on_quit_button_button_down() -> void:
	get_tree().quit()
