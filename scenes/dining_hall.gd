extends Node3D

@export var pause_menu: Control

@export var win_control: Control
@export var lose_control: Control

@export var interactions_icon: Sprite3D
@export var interactions_icon_animator: AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	win_control.hide()
	lose_control.hide()
	interactions_icon_animator.play("SpaceBar_UI")
	interactions_icon.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("back") and Dialogic.current_timeline == null:
		if GameManager.using_ui:
			GameManager.using_ui = false
			pause_menu.hide()
			
		else:
			GameManager.using_ui = true
			pause_menu.show()


func _on_lotus_area_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		interactions_icon.show()


func _on_lotus_area_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		interactions_icon.hide()
