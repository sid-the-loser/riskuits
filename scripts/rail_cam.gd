class_name RailCamera3D
extends Camera3D

@export var look_at_main_subject_: bool = true
@export var main_subject_: Node3D
@export var movement_speed_: float = 2.5
@export_enum("x", "y", "z") var rail_movement_axis = "x"
@export var rail_limit_1_: Node3D
@export var rail_limit_2_: Node3D
@export var ignore_rail_movement_: bool = false
@export_range(-100, 100, 0.5) var offset_: float = 0.0
@export var run_on_physics_process: bool = true

var rail_limit_min_: float = 0
var rail_limit_max_: float = 0

var first_frame_flag: bool = true

var feasible_position: Vector3 = Vector3.ZERO

func _ready() -> void:
	feasible_position = get_position()
	print(feasible_position, "fff")
	
	match rail_movement_axis:
		"x":
			rail_limit_max_ = rail_limit_1_.global_position.x if rail_limit_1_.global_position.x > rail_limit_2_.global_position.x else rail_limit_2_.global_position.x
			rail_limit_min_ = rail_limit_1_.global_position.x if rail_limit_1_.global_position.x < rail_limit_2_.global_position.x else rail_limit_2_.global_position.x
		"y":
			rail_limit_max_ = rail_limit_1_.global_position.y if rail_limit_1_.global_position.y > rail_limit_2_.global_position.y else rail_limit_2_.global_position.y
			rail_limit_min_ = rail_limit_1_.global_position.y if rail_limit_1_.global_position.y < rail_limit_2_.global_position.y else rail_limit_2_.global_position.y
		"z":
			rail_limit_max_ = rail_limit_1_.global_position.z if rail_limit_1_.global_position.z > rail_limit_2_.global_position.z else rail_limit_2_.global_position.z
			rail_limit_min_ = rail_limit_1_.global_position.z if rail_limit_1_.global_position.z < rail_limit_2_.global_position.z else rail_limit_2_.global_position.z

func _process(delta: float) -> void:
	if run_on_physics_process:
		mov_cam(delta)

func _physics_process(delta: float) -> void:
	if run_on_physics_process:
		mov_cam(delta)
	
func mov_cam(delta: float) -> void:
	if look_at_main_subject_:
		look_at(main_subject_.get_position())
	
	if !ignore_rail_movement_:
		match rail_movement_axis:
			"x":
				feasible_position.x = clamp(main_subject_.get_position().x + offset_, 
				rail_limit_min_, rail_limit_max_)
			"y":
				feasible_position.y = clamp(main_subject_.get_position().y + offset_, 
				rail_limit_min_, rail_limit_max_)
			"z":
				feasible_position.z = clamp(main_subject_.get_position().z + offset_, 
				rail_limit_min_, rail_limit_max_)
		
		if not first_frame_flag:
			set_position(
				get_position().lerp(feasible_position, movement_speed_ * delta))
		else:
			set_position(feasible_position)
			first_frame_flag = false
