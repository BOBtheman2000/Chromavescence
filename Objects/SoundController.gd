extends Node2D

class_name SoundController

func play_sound(path:String):
	get_node(path).play()
