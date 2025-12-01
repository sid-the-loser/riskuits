class_name PlayerAnimation
extends Node

@export_category("Sprites")
@export var forward_sprite_: Sprite3D
@export var forward_walk_sprite_: Sprite3D
@export var backward_sprite_: Sprite3D
@export var backward_walk_sprite_: Sprite3D
@export var side_sprite_: Sprite3D
@export var side_walk_sprite_: Sprite3D
@export_category("Animations")
@export var animation_player_: AnimationPlayer

var input_direction: Vector2 = Vector2.ZERO
var last_unique_input_direction: Vector2 = Vector2.ZERO

var idle_rendered_flag = false
var anim_pause_flag = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	idle_rendered_flag = true
	last_unique_input_direction = Vector2(0, 1)
	animation_player_.play("walk")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !GameManager.using_ui and Dialogic.current_timeline == null:
		input_direction = Input.get_vector("move_left", "move_right", 
											"move_up", "move_down")
		
		if anim_pause_flag:
			anim_pause_flag = false
		
		if input_direction != Vector2.ZERO:
			if input_direction != last_unique_input_direction:
				last_unique_input_direction = input_direction
				idle_rendered_flag = false
				
		elif !idle_rendered_flag:
			idle_rendered_flag = true
		
	elif !anim_pause_flag:
		input_direction = Vector2.ZERO
		anim_pause_flag = true
	
	update_sprite_rendered()
			
func update_sprite_rendered():
	forward_sprite_.hide()
	forward_walk_sprite_.hide()
	backward_sprite_.hide()
	backward_walk_sprite_.hide()
	side_sprite_.hide()
	side_walk_sprite_.hide()
	
	if input_direction != Vector2.ZERO:
		if input_direction.y > 0:
			forward_walk_sprite_.show()
			
		elif input_direction.y < 0:
			backward_walk_sprite_.show()
			
		elif abs(input_direction.x) > 0:
			side_walk_sprite_.show()
			if input_direction.x > 0:
				side_walk_sprite_.flip_h = true
			else:
				side_walk_sprite_.flip_h = false
				
	else:
		if last_unique_input_direction.y > 0:
			forward_sprite_.show()
			
		elif last_unique_input_direction.y < 0:
			backward_sprite_.show()
			
		elif abs(last_unique_input_direction.x) > 0:
			side_sprite_.show()
			side_sprite_.flip_h = side_walk_sprite_.flip_h
