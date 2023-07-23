extends CanvasLayer

var paused = false

@export var music_slider: VScrollBar
@export var sound_slider: VScrollBar

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
		visible = paused
		AudioServer.set_bus_effect_enabled(1, 0, paused)

func change_music(value):
	AudioServer.set_bus_volume_db(1, 0 - value)

func change_sound(value):
	AudioServer.set_bus_volume_db(4, 0 - value)
