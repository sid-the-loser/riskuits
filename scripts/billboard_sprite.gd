class_name BillboardSprite
extends Sprite3D

var current_camera: Camera3D = null

func _ready() -> void:
	current_camera = get_viewport().get_camera_3d()
	
func _process(delta: float) -> void:
	look_at(current_camera.get_position())
