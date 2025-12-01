extends Node3D

@export var pause_menu: Control

@export var interaction_icon: Sprite3D
@export var interaction_icon_animation: AnimationPlayer

@export var win_control: Control
@export var lose_control: Control

var talking_to_wafune_flag = false
var can_talk_to_wafune_flag = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.from_ = "lib"
	win_control.hide()
	lose_control.hide()
	interaction_icon.hide()
	interaction_icon_animation.play("Spacebar_UI")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Dialogic.current_timeline == null and talking_to_wafune_flag:
		if Dialogic.VAR.get_variable("bagged"):
			win_control.show()
		else:
			lose_control.show()
			
		GameManager.using_ui = true
	
	if Input.is_action_just_pressed("back") and Dialogic.current_timeline == null:
		if GameManager.using_ui:
			GameManager.using_ui = false
			pause_menu.hide()
			
		else:
			GameManager.using_ui = true
			pause_menu.show()
			
	if Dialogic.current_timeline == null and !GameManager.using_ui:
		if Input.is_action_just_pressed("talk") and can_talk_to_wafune_flag:
			Dialogic.start("wafune")
			talking_to_wafune_flag = true
			AudioManager.play_soundtrack("wafune")


func _on_exit_library_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		get_tree().call_deferred("change_scene_to_file", "res://scenes/hallway.tscn")


func _on_wafune_trigger_body_entered(body: Node3D) -> void:
	if body.name == 'Player':
		interaction_icon.show()
		can_talk_to_wafune_flag = true


func _on_wafune_trigger_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		interaction_icon.show()
		can_talk_to_wafune_flag = false


func _on_main_menu_button_down() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://scenes/main_menu.tscn")


func _on_main_menu_2_button_down() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://scenes/main_menu.tscn")
