extends CharacterBody3D

@export var player_animation: PlayerAnimation
@export var fade_animation: AnimationPlayer

var faded_out_flag = false

func _process(delta: float) -> void:
	if Dialogic.VAR.get_variable("cam_zoom"):
		if not faded_out_flag:
			fade_animation.play("fade_out")
			faded_out_flag = true
	elif faded_out_flag:
		fade_animation.play("fade_in")
		faded_out_flag = false
			
		

func _on_classroom_seated() -> void:
	player_animation.last_unique_input_direction = Vector2(0, -1)
