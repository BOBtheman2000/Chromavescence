extends TileMap

var active = true

func _ready():
	modulate.a = 1.0
	material.set_shader_parameter("enabled", false)

func set_active(force_to:bool):
	active = force_to
	modulate.a = 1.0 if force_to else 0.5
	material.set_shader_parameter("enabled", !active)
