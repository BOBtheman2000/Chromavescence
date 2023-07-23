extends Node

var playing = false
var volume_db = -80.0:
	set(value):
		for node in get_children():
			node.volume_db = value

# Called when the node enters the scene tree for the first time.
func play():
	playing = true
	for node in get_children():
		node.play()

func stop():
	playing = false
	for node in get_children():
		node.stop()
