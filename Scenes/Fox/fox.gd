extends Area2D

class_name Fox

signal point_scored

@export var speed: float = 700.0

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var sounds: AudioStreamPlayer2D = $Sounds


# movement still seems just a bit off. regardless of _process or _physics_process
# physics interpolation checkbox helps a decent amount but still not perfect
# actually turn off vsync for mac and that seems to do it

# if you run from editor, it looks way better, but running from project manager
# seems to pronounce the issue

# SOLUTION for cleanliness (no jitter, little to no laptop heat)
# 1. canvas items
# 2. use compatability render (OpenGL)
# 3. set max fps (60-90)
# 4. turn off vsync for macOS
func _physics_process(delta: float) -> void:
	var moveH: float = Input.get_axis("ui_left", "ui_right")
	position.x += moveH * speed * delta
	
	# optional vertical axis movement too. not normalized
	var moveV: float = Input.get_axis("ui_up", "ui_down")
	position.y += moveV * speed * delta
	
	if !is_zero_approx(moveH):
		sprite_2d.flip_h = moveH > 0.0


func _on_area_entered(area: Area2D) -> void:
	if area is Dice:
		sounds.play()
		area.queue_free()
		point_scored.emit()
	
