extends Node3D

signal seated

@export var pause_menu: Control
@export var biscuits: Node3D
@export var npcs: Node3D
@export var npcs_chairs: Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.from_ = "class"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Dialogic.current_timeline == null:
		if Input.is_action_just_pressed("back"):
			if GameManager.using_ui:
				GameManager.using_ui = false
				pause_menu.hide()
				
			else:
				GameManager.using_ui = true
				pause_menu.show()
				
	if Dialogic.VAR.get_variable("class_dis") and !GameManager.tutorial_flag:
		hide_all()

func hide_all():
	biscuits.hide()
	npcs.hide()
	npcs_chairs.show()


func _on_player_seat_body_entered(body: Node3D) -> void:
	if GameManager.tutorial_flag and body.name == "Player":
		GameManager.tutorial_flag = false
		body.position.x = -0.136
		body.position.z = -3.436
		Dialogic.start("classroom")
		seated.emit()


func _on_classroom_exit_body_entered(body: Node3D) -> void:
	if not GameManager.tutorial_flag and body.name == "Player":
		get_tree().call_deferred("change_scene_to_file", "res://scenes/hallway.tscn")
