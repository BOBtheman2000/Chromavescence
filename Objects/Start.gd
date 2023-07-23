extends PlayerState

func __physics_process(_delta):
	var direction = Input.get_axis("run_left", "run_right")
	if direction or Input.is_action_just_pressed("switch"):
		state_machine.change_state("Run")

func camera_logic():
	var cam_target_pos = player.CAMERA_OFFSET.x * player.velocity.x / player.MAX_RUN_SPEED
	player.camera.position.x = lerpf(player.camera.position.x, cam_target_pos, 0.06)
	player.camera.position.y = lerpf(player.camera.position.y, 0, 0.04)
