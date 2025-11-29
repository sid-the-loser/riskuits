class_name PlayerMovement
extends Node

@export var parent_character_body: CharacterBody3D
@export var walk_speed: float = 300

var input_direction: Vector3 = Vector3.ZERO

var movement_speed: float = 0

var sprinting: bool = false

func _ready() -> void:
	if parent_character_body == null:
		print("Character body not attached to PlayerMovement node")
		
	movement_speed = walk_speed
		
func _process(delta: float) -> void:
	input_direction = Vector3(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		0,
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up"),
	)
	
func _physics_process(delta: float) -> void:
	if Dialogic.current_timeline == null and !GameManager.using_ui:
		parent_character_body.set_velocity(input_direction * movement_speed * delta)
		
		parent_character_body.move_and_slide()
