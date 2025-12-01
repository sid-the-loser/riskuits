extends Node3D

signal seated

@onready var pause_menu: Control = $PauseMenu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("back") and Dialogic.current_timeline == null:
		if GameManager.using_ui:
			GameManager.using_ui = false
			pause_menu.hide()
			
		else:
			GameManager.using_ui = true
			pause_menu.show()


func _on_player_seat_body_entered(body: Node3D) -> void:
	if GameManager.tutorial_flag and body.name == "Player":
		GameManager.tutorial_flag = false
		body.position.x = -0.065
		body.position.z = -2.929
		Dialogic.start("classroom")
		seated.emit()


func _on_classroom_exit_body_entered(body: Node3D) -> void:
	if not GameManager.tutorial_flag and body.name == "Player":
		get_tree().call_deferred("change_scene_to_file", "res://scenes/hallway.tscn")
