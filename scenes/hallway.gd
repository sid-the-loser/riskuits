extends Node3D


const CLASSROOM = preload("uid://c4iijybop1qfa")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GameManager.tutorial_flag:
		Dialogic.start("pre_classroom_hallway")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_classroom_entrance_body_entered(body: Node3D) -> void:
	if GameManager.tutorial_flag:
		get_tree().change_scene_to_packed(CLASSROOM)
