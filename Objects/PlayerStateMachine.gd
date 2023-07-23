extends StateMachine

class_name PlayerStateMachine
@export var player: Player

func _physics_process(delta):
	state.__physics_process(delta)
	state.camera_logic()

func bounce(strength, dir):
	if state.has_method("bounce"):
		state.bounce(strength, dir)
