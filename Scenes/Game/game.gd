extends Node2D

const DICE = preload("res://Scenes/Dice/dice.tscn")
const MARGIN: float = 80.0
const STOPPABLE: String = "stoppable"
const GAME_OVER = preload("uid://svpflsu5jowm")

var _points: int = 0

@onready var spawn_timer: Timer = $SpawnTimer
@onready var score_label: Label = $ScoreLabel
@onready var music: AudioStreamPlayer2D = $Music

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()

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
	pause_all_dice()
	music.stop()
	music.stream = GAME_OVER
	music.play()

func pause_all_dice() -> void:
	spawn_timer.stop()
	var stop: Array[Node] = get_tree().get_nodes_in_group(STOPPABLE)
	for item in stop:
		item.set_physics_process(false)
	

func _on_spawn_timer_timeout() -> void:
	spawn_dice()


func _on_fox_point_scored() -> void:
	print("fox has eaten dice")
	_points += 1
	score_label.text = "Score: %04d" % _points
