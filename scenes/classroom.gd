extends Node3D


const HALLWAY = preload("uid://d0jasc8dyycal")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_seat_body_entered(body: Node3D) -> void:
	if GameManager.tutorial_flag and body.name == "Player":
		GameManager.tutorial_flag = false
		body.position.x = -0.065
		body.position.z = -2.929
		Dialogic.start("classroom")


func _on_classroom_exit_body_entered(body: Node3D) -> void:
	if not GameManager.tutorial_flag and body.name == "Player":
		get_tree().change_scene_to_packed(HALLWAY)
