extends Area2D

@export var player: Player

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", set_spawn)

func set_spawn(_body):
	player.spawn_point = player.to_local(to_global(position))
