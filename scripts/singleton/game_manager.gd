extends Node

# TODO: needs to change if we have ui in the main menu
var using_ui: bool = false

var task_list: Array[String] = []

var tutorial_flag = true

var from_: String = "class"

var debug_mode: bool = false

var fullscreen = true

# TODO: Add settings saving and loading

func _ready() -> void:
	debug_mode = OS.is_debug_build()
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _input(event: InputEvent) -> void:
	if debug_mode:
		if event.is_action_pressed("debug_exit"):
			get_tree().quit()
			
	if event.is_action_pressed("debug_fullscreen_toggle"):
		if fullscreen:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		
		fullscreen = !fullscreen
