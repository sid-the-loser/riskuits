extends Node3D


@onready var animation_player: AnimationPlayer = $Camera3D/AnimationPlayer
@onready var animation_player_gals: AnimationPlayer = $Control/TextureRect3/AnimationPlayer

var load_these: Array[String] = [ # NOTE: might or might not be effective
	"res://scenes/main_menu.tscn",
	"res://scenes/hallway.tscn",
	"res://scenes/classroom.tscn",
	"res://scenes/dining_hall.tscn",
	"res://scenes/library.tscn"
]

func _ready():
	for i in load_these:
		ResourceLoader.load_threaded_request(i)
		
	animation_player.play("TitleScreenCameraMove")
	animation_player_gals.play("TitleGals")
	AudioManager.play_soundtrack("title")
	GameManager.from_ = "start"
	
func _on_play_button_button_down() -> void:
	GameManager.tutorial_flag = true
	GameManager.using_ui = false
	GameManager.from_ = "start"
	get_tree().change_scene_to_file("res://scenes/hallway.tscn")


func _on_skip_intro_button_button_down() -> void:
	GameManager.tutorial_flag = false
	GameManager.using_ui = false
	GameManager.from_ = "class"
	get_tree().change_scene_to_file("res://scenes/hallway.tscn")


func _on_quit_button_button_down() -> void:
	get_tree().quit()
