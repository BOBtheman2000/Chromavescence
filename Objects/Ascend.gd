extends PlayerState


# Called when the node enters the scene tree for the first time.
func _enter():
	player = state_machine.player
	player.change_animation(anim)
	player.sounds.play_sound("Ascend")
	player.end_particles.emitting = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func __physics_process(_delta):
	pass

func camera_logic():
	var cam_target_pos = player.CAMERA_OFFSET.x * player.velocity.x / player.MAX_RUN_SPEED
	player.camera.position.x = lerpf(player.camera.position.x, cam_target_pos, 0.06)
	player.camera.position.y = lerpf(player.camera.position.y, 0, 0.04)

func _on_ascend_finished():
	player.sprite.visible = false
	player.ending()
