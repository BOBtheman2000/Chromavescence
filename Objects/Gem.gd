extends Area2D

signal gem_collected

@export var meta: Meta

@export var sprite: AnimatedSprite2D
@export var sounds: SoundController
@export var particles: GPUParticles2D

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", collect, CONNECT_ONE_SHOT)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	sprite.offset.y = sin(Time.get_ticks_msec() / 120.0) * 3

func collect(_body):
	gem_collected.emit()
	sounds.play_sound("Collect")
	particles.emitting = true
	sprite.visible = false
	meta.collect_gem()
