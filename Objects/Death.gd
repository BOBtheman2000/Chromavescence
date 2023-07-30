extends PlayerState

var death_timer = 0

func _enter():
	player = state_machine.player
	player.change_animation(anim)
	player.sounds.play_sound("Death")
	death_timer = 1
	player.sprite.visible = false
	player.particles.emitting = true
	player.velocity = Vector2(0, 0)
	player.killbox.set_deferred("monitoring", false)

func __physics_process(delta):
	death_timer = max(0, death_timer - delta)
	if death_timer <= 0:
		player.sprite.visible = true
		player.position = player.spawn_point
		player.velocity = Vector2(0, 0)
		player.killbox.set_deferred("monitoring", true)
		player.sounds.play_sound("Respawn")
		state_machine.change_state("Idle")

func camera_logic():
	var cam_target_pos = player.CAMERA_OFFSET.x * player.velocity.x / player.MAX_RUN_SPEED
	player.camera.position.x = lerpf(player.camera.position.x, cam_target_pos, 0.06)
	player.camera.position.y = lerpf(player.camera.position.y, 0, 0.04)
