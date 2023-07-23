extends Area2D

@export_range(0.1, 3.0) var zoom_range = 1.0
@export var cam_offset = Vector2(0, 0)
@export var meta: Meta

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", zoom_camera)

func zoom_camera(_body):
	meta.zoom_camera(zoom_range, cam_offset)
