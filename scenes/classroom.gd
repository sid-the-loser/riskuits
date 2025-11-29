extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_seat_body_entered(body: Node3D) -> void:
	body.position.x = -0.065
	body.position.z = -2.929
	Dialogic.start("classroom")
