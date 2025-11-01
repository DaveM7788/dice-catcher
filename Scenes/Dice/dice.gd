extends Area2D

class_name Dice

signal game_over

@onready var dice_sprite: Sprite2D = $Sprite2D
const ROT_SPEED: float = 3.0
const FALL_SPEED: float = 120.0

var rot_dir: float = 1.0

func _ready() -> void:
	if randf() > 0.5: rot_dir *= -1.0

func _physics_process(delta: float) -> void:
	position.y += delta * FALL_SPEED
	dice_sprite.rotate(ROT_SPEED * delta * rot_dir)
	check_game_over()

func check_game_over() -> void:
	if position.y > get_viewport_rect().end.y:
		print("Dice reached bottom of screen. Game over!")
		set_physics_process(false)
		queue_free()
		game_over.emit()
