extends CanvasLayer

var paused = false

@export var music_slider: VScrollBar
@export var sound_slider: VScrollBar

@export var ui: Control

# Called when the node enters the scene tree for the first time.
func _ready():
	var music_volume = AudioServer.get_bus_volume_db(1)
	var sound_volume = AudioServer.get_bus_volume_db(4)
	music_slider.value = -music_volume
	sound_slider.value = -sound_volume

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		$PauseSound.play()
		paused = !paused
		get_tree().paused = paused
		AudioServer.set_bus_effect_enabled(1, 0, paused)
		
		var tween = get_tree().create_tween()
		tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(ui, "scale:y", int(paused), 0.1)
		if paused:
			visible = true
		else:
			tween.tween_property(self, "visible", false, 0.0)
		

func change_music(value):
	AudioServer.set_bus_volume_db(1, 0 - value)

func change_sound(value):
	AudioServer.set_bus_volume_db(4, 0 - value)
