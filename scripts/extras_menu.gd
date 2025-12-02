extends Control


@export var animation_player: AnimationPlayer

var opened = false

func trigger():
	if opened:
		animation_player.play("close")
		opened = false
	else:
		animation_player.play("open")
		opened = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("back"):
		trigger()

func _on_open_close_button_up() -> void:
	trigger()


func _on_main_menu_button_button_up() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://scenes/main_menu.tscn")
