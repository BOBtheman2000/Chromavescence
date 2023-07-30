extends Area2D

@export var player: Player
@export var meta: Meta

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", set_spawn)

func set_spawn(_body):
	player.spawn_point = meta.to_local(get_parent().to_global(position))
