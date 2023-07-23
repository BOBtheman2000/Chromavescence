# State machine stolen from another project of mine
extends Node

class_name StateMachine

# Default finite state machine behaviour, 

var state: Object

# Set default state
func _ready():
	state = get_child(0)
	enter_state()
	

# Initiate state
func enter_state():
	state.state_machine = self
	state._enter()

# Update state to new state
func change_state(state_path: NodePath):
	state._exit()
	state = get_node(state_path)
	enter_state()
