extends Area2D

class_name Killbox
@export var player: Player

func _ready():
	connect("body_entered", kill_player)

func kill_player(_body):
	player.kill()
