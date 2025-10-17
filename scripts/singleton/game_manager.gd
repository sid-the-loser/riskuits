extends Node

# TODO: needs to change if we have ui in the main menu
var using_ui: bool = false

# NOTE: Change before publishing
var debug_mode: bool = false

func _ready() -> void:
	debug_mode = OS.is_debug_build()

func _input(event: InputEvent) -> void:
	if debug_mode:
		if event.is_action_pressed("debug_exit"):
			get_tree().quit()
