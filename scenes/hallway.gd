extends Node3D


@export var limit_2: Camera3D

@export var player: CharacterBody3D
#@export var pause_menu: Control

@export var ginna: Sprite3D
@export var interaction_icon: Sprite3D

@export var ginna_animator: AnimationPlayer
@export var interaction_animator: AnimationPlayer

@export var win_control: Control
@export var lose_control: Control

@export var Cam1: RailCamera3D
@export var Cam2: RailCamera3D

var x_cam_flag = false

var talking_to_ginna_flag = false
var can_talk_to_ginna_flag = false
var ended_flag = false

var win_or_lose_anim_flag = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioManager.play_soundtrack("level")
	#pause_menu.hide()
	interaction_icon.hide()
	win_control.hide()
	lose_control.hide()
	ginna_animator.play("GinnaBobbing")
	interaction_animator.play("SpaceBar_UI")
	if GameManager.tutorial_flag:
		AudioManager.fade_out()
		ginna.hide()
		Dialogic.start("pre_classroom_hallway")
		limit_2.position.z = -40.0
		Cam1.update_limits()
		GameManager.task_list.append("Go to class!")
	else:
		AudioManager.door_close()
		ginna.show()
		if GameManager.from_ == "caf":
			player.position = Vector3(-4.405, 1.0, -96.29)
		elif GameManager.from_ == "lib":
			player.position = Vector3(72.079, 1.0, -62.963)
		elif GameManager.from_ == "start":
			player.position = Vector3(-4.083, 1.0, 12.088)
		else:
			player.position = Vector3(-13.212, 1.0, -23.651)
		limit_2.position.z = -107.416
		Cam1.update_limits()
		GameManager.task_list.append("Rizz the biscuits!")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if x_cam_flag:
		Cam1.current = false
		Cam2.current = true
	else:
		Cam1.current = true
		Cam2.current = false
	
	if Dialogic.current_timeline == null:
		#if !ended_flag:
			#if Input.is_action_just_pressed("back"):
				#if GameManager.using_ui:
					#GameManager.using_ui = false
					#pause_menu.hide()
				#
				#else:
					#GameManager.using_ui = true
					#pause_menu.show()
		
		if !GameManager.using_ui:
			if Input.is_action_just_pressed("talk") and can_talk_to_ginna_flag and !talking_to_ginna_flag:
				Dialogic.start("ginna")
				AudioManager.play_soundtrack("ginna")
				talking_to_ginna_flag = true
			
			elif talking_to_ginna_flag:
				ended_flag = true
				
		if ended_flag:
			if Dialogic.VAR.get_variable("bagged"):
				win_control.show()
				if !win_or_lose_anim_flag:
					$Win/AnimationPlayer.play("Ginna_Win_Animation")
					win_or_lose_anim_flag = true
				
			else:
				lose_control.show()
				if !win_or_lose_anim_flag:
					$Lose/AnimationPlayer.play("Ginna_Lose_Animation");
					win_or_lose_anim_flag = true
			GameManager.using_ui = true
			

func _on_classroom_entrance_body_entered(body: Node3D) -> void:
	if GameManager.tutorial_flag and body.name == "Player":
		AudioManager.door_open()
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


func _on_x_cam_trigger_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		x_cam_flag = true


func _on_x_cam_trigger_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		x_cam_flag = false


func _on_caf_entrance_body_entered(body: Node3D) -> void:
	if !GameManager.tutorial_flag and body.name == "Player":
		AudioManager.door_open()
		get_tree().call_deferred("change_scene_to_file", "res://scenes/dining_hall.tscn")

func _on_lib_entrance_body_entered(body: Node3D) -> void:
	if !GameManager.tutorial_flag and body.name == "Player":
		AudioManager.door_open()
		get_tree().call_deferred("change_scene_to_file", "res://scenes/library.tscn")
