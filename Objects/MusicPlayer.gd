extends Area2D

@export_enum("Intro", "Game") var music: String
@export var music_controller: MusicController
@export var oneshot: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", play_music)

func play_music(_body):
	music_controller.play_music(music)
	if oneshot:
		queue_free()
