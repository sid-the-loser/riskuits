extends Node3D

signal seated

#@export var pause_menu: Control
@export var biscuits: Node3D
@export var npcs: Node3D
@export var npcs_chairs: Node3D
@export var cam: RailCamera3D
@export var cam_rotation_change: Vector3 = Vector3(-6.4, 0, 0)
@export var fov_chanage: float = 14.7

var default_fov: float = 60.0
var default_rotation: Vector3 = Vector3(-12.7, 0, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioManager.door_close()
	GameManager.from_ = "class"
	Dialogic.VAR.set_variable("cam_zoom", false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if Dialogic.current_timeline == null:
		#if Input.is_action_just_pressed("back"):
			#if GameManager.using_ui:
				#GameManager.using_ui = false
				#pause_menu.hide()
				#
			#else:
				#GameManager.using_ui = true
				#pause_menu.show()
				
	if Dialogic.VAR.get_variable("cam_zoom"):
		cam.fov = lerp(cam.fov, fov_chanage, delta)
		cam.global_rotation = cam_rotation_change
	else:
		cam.fov = lerp(cam.fov, default_fov, delta)
		cam.global_rotation = default_rotation
				
	if Dialogic.VAR.get_variable("class_dis") and !GameManager.tutorial_flag:
		hide_all()

func hide_all():
	biscuits.hide()
	npcs.hide()
	npcs_chairs.show()


func _on_player_seat_body_entered(body: Node3D) -> void:
	if GameManager.tutorial_flag and body.name == "Player":
		GameManager.tutorial_flag = false
		body.position.x = -0.136
		body.position.z = -3.436
		Dialogic.start("classroom")
		seated.emit()


func _on_classroom_exit_body_entered(body: Node3D) -> void:
	if not GameManager.tutorial_flag and body.name == "Player":
		AudioManager.door_open()
		get_tree().call_deferred("change_scene_to_file", "res://scenes/hallway.tscn")
