extends Area2D

class_name Dice

@onready var dice_sprite: Sprite2D = $Sprite2D
const ROT_SPEED: float = 3.0
const FALL_SPEED: float = 70.0

var rot_dir: float = 1.0

func _ready() -> void:
	if randf() > 0.5: rot_dir *= -1.0
	pass

func _physics_process(delta: float) -> void:
	position.y += delta * FALL_SPEED
	dice_sprite.rotate(ROT_SPEED * delta * rot_dir)
	pass
