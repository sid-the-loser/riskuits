extends Control



func _on_main_menu_button_down() -> void:
	GameManager.tutorial_flag = true
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_hallway_tutorial_button_down() -> void:
	GameManager.tutorial_flag = true
	get_tree().change_scene_to_file("res://scenes/hallway.tscn")


func _on_hallway_button_down() -> void:
	GameManager.tutorial_flag = false
	get_tree().change_scene_to_file("res://scenes/hallway.tscn")


func _on_classroom_tutorial_button_down() -> void:
	GameManager.tutorial_flag = true
	get_tree().change_scene_to_file("res://scenes/classroom.tscn")


func _on_classroom_button_down() -> void:
	GameManager.tutorial_flag = false
	get_tree().change_scene_to_file("res://scenes/classroom.tscn")
