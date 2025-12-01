# Script taken from: https://youtu.be/aVZb7Aj-9ug

extends Node3D


@export var cam_collider: RayCast3D
@export var camera_3d: Camera3D
@export var max_cam_position: Node3D

@export var run_in_physics_process_ : bool = true

func _process(delta: float) -> void:
	if !run_in_physics_process_:
		if cam_collider.is_colliding():
			camera_3d.global_transform.origin = cam_collider.get_collision_point()
		else:
			camera_3d.global_transform.origin = max_cam_position.global_transform.origin
			
func _physics_process(delta: float) -> void:
	if run_in_physics_process_:
		if cam_collider.is_colliding():
			camera_3d.global_transform.origin = cam_collider.get_collision_point()
		else:
			camera_3d.global_transform.origin = max_cam_position.global_transform.origin
