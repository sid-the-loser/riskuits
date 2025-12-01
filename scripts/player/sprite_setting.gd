extends CharacterBody3D

@onready var player_animation: PlayerAnimation = $PlayerAnimation


func _on_classroom_seated() -> void:
	player_animation.last_unique_input_direction = Vector2(0, -1)
