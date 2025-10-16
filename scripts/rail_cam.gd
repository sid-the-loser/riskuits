class_name RailCamera3D
extends Camera3D

@export var look_at_main_subject_: bool = true
@export var main_subject_: Node3D
@export var movement_speed_: float = 2.5
@export_enum("x", "y", "z") var rail_movement_axis = "x"
@export var offset_: float = 0.0

var feasible_position: Vector3 = Vector3.ZERO

func _ready() -> void:
	feasible_position = get_position()

func _process(delta: float) -> void:
	if look_at_main_subject_:
		look_at(main_subject_.get_position())
		
	match rail_movement_axis:
		"x":
			feasible_position.x = main_subject_.get_position().x + offset_
		"y":
			feasible_position.y = main_subject_.get_position().y + offset_
		"z":
			feasible_position.z = main_subject_.get_position().z + offset_
	
	set_position(
		get_position().lerp(feasible_position, movement_speed_ * delta))
