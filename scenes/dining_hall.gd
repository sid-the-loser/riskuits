extends Node3D

@export var pause_menu: Control

@export var win_control: Control
@export var lose_control: Control

@export var interactions_icon: Sprite3D
@export var interactions_icon_animator: AnimationPlayer

@onready var animation_player: AnimationPlayer = $Win/AnimationPlayer
@onready var animation_player_lose: AnimationPlayer = $Lose/AnimationPlayer


@export var lotus_animatior: AnimationPlayer

var talking_to_lotus_flag = false
var can_talk_to_lotus_flag = false
var win_or_lose_anim_flag = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioManager.door_close()
	GameManager.from_ = "caf"
	win_control.hide()
	lose_control.hide()
	interactions_icon_animator.play("SpaceBar_UI")
	lotus_animatior.play("LotusBobbing")
	interactions_icon.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if talking_to_lotus_flag and Dialogic.current_timeline == null:
		if Dialogic.VAR.get_variable("bagged"):
			win_control.show()
			if !win_or_lose_anim_flag:
				$Win/AnimationPlayer.play("Lotus_Win_Animation")
				win_or_lose_anim_flag = true
		else:
			lose_control.show()
			if !win_or_lose_anim_flag:
				$Lose/AnimationPlayer.play("Lotus_Lose_Animation")
				win_or_lose_anim_flag = true
		GameManager.using_ui = true
		
	if Input.is_action_just_pressed("back") and Dialogic.current_timeline == null:
		if GameManager.using_ui:
			GameManager.using_ui = false
			pause_menu.hide()
			
		else:
			GameManager.using_ui = true
			pause_menu.show()
			
	if Dialogic.current_timeline == null and !GameManager.using_ui:
		if Input.is_action_just_pressed("talk") and can_talk_to_lotus_flag:
			Dialogic.start("lotus")
			talking_to_lotus_flag = true
			AudioManager.play_soundtrack("lotus")

func _on_lotus_area_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		interactions_icon.show()
		can_talk_to_lotus_flag = true


func _on_lotus_area_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		interactions_icon.hide()
		can_talk_to_lotus_flag = false


func _on_exit_hallway_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		AudioManager.door_open()
		get_tree().call_deferred("change_scene_to_file", "res://scenes/hallway.tscn")


func _on_main_menu_button_down() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://scenes/main_menu.tscn")


func _on_main_menu_2_button_down() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://scenes/main_menu.tscn")
