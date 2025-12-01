extends Node3D


@onready var player: CharacterBody3D = $Player
@onready var pause_menu: Control = $PauseMenu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pause_menu.hide()
	if GameManager.tutorial_flag:
		Dialogic.start("pre_classroom_hallway")
	else:
		player.position = Vector3(-13.212, 1.0, -23.651)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("back") and Dialogic.current_timeline == null:
		if GameManager.using_ui:
			GameManager.using_ui = false
			pause_menu.hide()
			
		else:
			GameManager.using_ui = true
			pause_menu.show()

func _on_classroom_entrance_body_entered(body: Node3D) -> void:
	if GameManager.tutorial_flag and body.name == "Player":
		get_tree().call_deferred("change_scene_to_file", "res://scenes/classroom.tscn")
