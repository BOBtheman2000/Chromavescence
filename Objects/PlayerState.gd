extends State

class_name PlayerState

@export_enum("start", "idle", "run", "dash", "jump", "ascend") var anim: String
var player: Player

func _enter():
	player = state_machine.player
	player.change_animation(anim)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
