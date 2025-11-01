extends Node2D

const DICE = preload("res://Scenes/Dice/dice.tscn")
const MARGIN: float = 80.0

func _ready() -> void:
	spawn_dice()

func spawn_dice() -> void:
	var new_dice: Dice = DICE.instantiate()
	var randx: float = randf_range(
		0 + MARGIN, get_viewport_rect().end.x - MARGIN
	)
	new_dice.position = Vector2(randx, -MARGIN)
	new_dice.game_over.connect(_on_dice_game_over)
	add_child(new_dice)

func _on_dice_game_over() -> void:
	print("Signal for game is over found")

func _on_spawn_timer_timeout() -> void:
	spawn_dice()
