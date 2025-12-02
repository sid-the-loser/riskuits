extends Control


@export var animation_player: AnimationPlayer
@export var task_label: RichTextLabel

var opened = false

func trigger():
	update_tasks()
	if opened:
		animation_player.play("close")
		opened = false
	else:
		animation_player.play("open")
		opened = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("back"):
		trigger()
		

func update_tasks():
	var txt = ""
	
	for i in range(len(GameManager.task_list)):
		if len(GameManager.task_list)-1 != i:
			txt += "[s]" + GameManager.task_list[i] + "[/s]\n"
		else:
			txt += GameManager.task_list[i] + "\n"
			
	task_label.text = txt


func _on_open_close_button_up() -> void:
	trigger()


func _on_main_menu_button_button_up() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://scenes/main_menu.tscn")
