extends Node2D

class_name MusicController

var playing = false
var current_target_track = null

func play_music(path:String):
	var target_track = get_node(path)
	
	if target_track == current_target_track:
		return
	
	for node in get_children():
		
		var target_volume = -80.0
		
		var tween = get_tree().create_tween()
		tween.set_trans(Tween.TRANS_CUBIC)
		tween.set_ease(Tween.EASE_IN)
		
		if node == target_track:
			target_volume = 0.0
			tween.set_ease(Tween.EASE_OUT)
		
		if !playing:
			node.play()
		
		tween.tween_property(node, "volume_db", target_volume, 0.5)
	
	current_target_track = target_track
	playing = true

func stop_all_music():
	for node in get_children():
		var tween = get_tree().create_tween()
		tween.set_trans(Tween.TRANS_CUBIC)
		tween.set_ease(Tween.EASE_IN)
		tween.tween_property(node, "volume_db", -80.0, 1.8)
