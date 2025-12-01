extends Node3D


@export var limit_2: Camera3D
@export var rail_camera_3d: RailCamera3D

@export var player: CharacterBody3D
@export var pause_menu: Control

@export var ginna: Sprite3D
@export var interaction_icon: Sprite3D

@export var win_control: Control
@export var lose_control: Control

var talking_to_ginna_flag = false
var can_talk_to_ginna_flag = false
var ended_flag = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pause_menu.hide()
	interaction_icon.hide()
	win_control.hide()
	lose_control.hide()
	if GameManager.tutorial_flag:
		ginna.hide()
		Dialogic.start("pre_classroom_hallway")
		limit_2.position.z = -41.782
	else:
		ginna.show()
		player.position = Vector3(-13.212, 1.0, -23.651)
		limit_2.position.z = -107.416
		
	rail_camera_3d.update_limits()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Dialogic.current_timeline == null:
		if !GameManager.tutorial_flag:
			if talking_to_ginna_flag:
				if Dialogic.VAR.get_variable("bagged"):
					GameManager.using_ui = true
					win_control.show()
				else:
					GameManager.using_ui = true
					lose_control.show()
					
			ended_flag = true
			talking_to_ginna_flag = false
				
			if Input.is_action_just_pressed("talk") and can_talk_to_ginna_flag:
				Dialogic.start("ginna")
				print(Dialogic.VAR.get_variable("bagged"))
				talking_to_ginna_flag = true
				
		if !ended_flag:
			if Input.is_action_just_pressed("back"):
				if GameManager.using_ui:
					GameManager.using_ui = false
					pause_menu.hide()
				
				else:
					GameManager.using_ui = true
					pause_menu.show()

func _on_classroom_entrance_body_entered(body: Node3D) -> void:
	if GameManager.tutorial_flag and body.name == "Player":
		get_tree().call_deferred("change_scene_to_file", "res://scenes/classroom.tscn")


func _on_area_3d_body_entered(body: Node3D) -> void:
	if not GameManager.tutorial_flag and body.name == "Player":
		interaction_icon.show()
		can_talk_to_ginna_flag = true

func _on_area_3d_body_exited(body: Node3D) -> void:
	if not GameManager.tutorial_flag and body.name == "Player":
		interaction_icon.hide()
		can_talk_to_ginna_flag = false


func _on_main_menu_button_down() -> void:
	GameManager.tutorial_flag = true
	GameManager.using_ui = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_main_menu_2_button_down() -> void:
	GameManager.tutorial_flag = true
	GameManager.using_ui = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
