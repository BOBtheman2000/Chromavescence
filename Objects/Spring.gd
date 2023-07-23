extends Area2D

@export_range(100.0, 1000.0) var bounce_strength = 500.0
@export var sprite: AnimatedSprite2D
@export var sounds: SoundController

func _ready():
	connect("body_entered", bounce)

func bounce(body):
	sprite.play("bounce")
	sounds.play_sound("Bounce")
	body.bounce(bounce_strength, Vector2.UP.rotated(rotation))
