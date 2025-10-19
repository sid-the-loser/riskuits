class_name BillboardSprite
extends Sprite3D

#var current_camera: Camera3D = null
#var converted_pos: Vector3 = Vector3.ZERO
#
#func _ready() -> void:
	#current_camera = get_viewport().get_camera_3d()
	#converted_pos.y = position.y
	#
#func _process(delta: float) -> void:
	#converted_pos.x = current_camera.get_position().x
	#converted_pos.z = current_camera.get_position().z
	#look_at(converted_pos)
