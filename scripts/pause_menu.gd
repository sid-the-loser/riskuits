extends Control


func _process(delta: float) -> void:
	GameManager.using_ui = true if is_visible_in_tree() else false


func _on_resume_button_down() -> void:
	GameManager.using_ui = false
	hide()


func _on_quit_mm_button_down() -> void:
	GameManager.tutorial_flag = true
	GameManager.using_ui = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_quit_g_button_down() -> void:
	get_tree().quit()
