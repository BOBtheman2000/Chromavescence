extends Node2D

class_name Meta

@export var player: Player
@export var camera: Camera2D
@export var screen_shader: Sprite2D
@export var sounds: SoundController
@export var music: MusicController
@export var gem_text: Label

var in_alt_world = false

var gem_count = 0

func _ready():
	$WorldB.set_active(false)
	var audio = AudioServer
	audio.set_bus_volume_db(3, -80.0)

func switch_worlds():
	
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT if in_alt_world else Tween.EASE_IN)
	
	if in_alt_world:
		$WorldA.set_active(true)
		$WorldB.set_active(false)
		
		AudioServer.set_bus_volume_db(2, -80.0)
		AudioServer.set_bus_volume_db(3, 0.0)
		
		tween.tween_property(screen_shader, "scale", Vector2(0, 0), 0.3)
	else:
		$WorldA.set_active(false)
		$WorldB.set_active(true)
		
		AudioServer.set_bus_volume_db(3, -80.0)
		AudioServer.set_bus_volume_db(2, 0.0)
		
		var meta_scale = (get_viewport_transform().get_scale().x) * camera.zoom.x
		tween.tween_property(screen_shader, "scale", Vector2(meta_scale, meta_scale), 0.3)
		
	in_alt_world = !in_alt_world
	
	sounds.play_sound("Switch")
	
	return in_alt_world

func zoom_camera(zoom:float, offset:Vector2):
	var tween_zoom = get_tree().create_tween()
	tween_zoom.set_trans(Tween.TRANS_QUART)
	tween_zoom.set_ease(Tween.EASE_OUT)
	
	var tween_offset = get_tree().create_tween()
	tween_offset.set_trans(Tween.TRANS_QUART)
	tween_offset.set_ease(Tween.EASE_OUT)
	
	tween_zoom.tween_property(camera, "zoom", Vector2(zoom, zoom), 1.0)
	tween_offset.tween_property(camera, "offset", offset, 1.0)
	if in_alt_world:
		var shader_scale = (get_viewport_transform().get_scale().x) * camera.zoom.x
		screen_shader.scale = Vector2(shader_scale, shader_scale)

func collect_gem():
	gem_count += 1
	gem_text.text = str(gem_count) + " / 5"
	gem_text.modulate.a = 1.0
	
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_EXPO)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(gem_text, "modulate:a", 0.0, 2.0)
	
	if gem_count >= 5:
		player.ascend()
		music.stop_all_music()
