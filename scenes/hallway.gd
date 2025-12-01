extends Node3D


var talking_to_ginna_flag = false
var can_talk_to_ginna_flag = false
var ended_flag = false

@onready var player: CharacterBody3D = $Player
@onready var pause_menu: Control = $PauseMenu

@onready var ginna: Sprite3D = $Ginna
@onready var interaction_icon: Sprite3D = $InteractionIcon

@onready var win_control: Control = $Win
@onready var lose_control: Control = $Lose

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pause_menu.hide()
	interaction_icon.hide()
	if GameManager.tutorial_flag:
		ginna.hide()
		Dialogic.start("pre_classroom_hallway")
	else:
		ginna.show()
		player.position = Vector3(-13.212, 1.0, -23.651)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Dialogic.current_timeline == null and !GameManager.tutorial_flag:
		if talking_to_ginna_flag:
			if Dialogic.VAR.get_variable("bagged"):
				GameManager.using_ui = true
				win_control.show()
			else:
				GameManager.using_ui = true
				win_control.show()
				
			ended_flag = true
			talking_to_ginna_flag = false
		
		if !ended_flag:
			if Input.is_action_just_pressed("back"):
				if GameManager.using_ui:
					GameManager.using_ui = false
					pause_menu.hide()
					
				else:
					GameManager.using_ui = true
					pause_menu.show()
				
			if Input.is_action_just_pressed("talk") and can_talk_to_ginna_flag:
				Dialogic.start("ginna")
				print(Dialogic.VAR.get_variable("bagged"))
				talking_to_ginna_flag = true

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
