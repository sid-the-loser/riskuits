class_name player_movement
extends Node

@export var parent_controller: CharacterBody2D
@export var walking_speed: float = 10
@export var sprinting_speed: float = 20

var movement_direction: Vector2 = Vector2.ZERO
@onready var movement_speed: float = walking_speed

func _ready() -> void:
	if parent_controller == null: 
		# debug message to remind me to assign to characterbody
		print("Parent not assigned to player_movement Node!")
		
func _input(event: InputEvent) -> void:
	pass
