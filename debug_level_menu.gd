extends Control


const CLASSROOM = preload("uid://c4iijybop1qfa")
const HALLWAY = preload("uid://d0jasc8dyycal")
const MAIN_MENU = preload("uid://ciinhkhf0s14n")



func _on_main_menu_button_down() -> void:
	GameManager.tutorial_flag = true
	get_tree().change_scene_to_packed(MAIN_MENU)


func _on_hallway_tutorial_button_down() -> void:
	GameManager.tutorial_flag = true
	get_tree().change_scene_to_packed(HALLWAY)


func _on_hallway_button_down() -> void:
	GameManager.tutorial_flag = false
	get_tree().change_scene_to_packed(HALLWAY)


func _on_classroom_tutorial_button_down() -> void:
	GameManager.tutorial_flag = true
	get_tree().change_scene_to_packed(CLASSROOM)


func _on_classroom_button_down() -> void:
	GameManager.tutorial_flag = false
	get_tree().change_scene_to_packed(CLASSROOM)
