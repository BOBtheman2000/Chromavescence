extends PlayerState

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _enter():
	player = state_machine.player
	player.change_animation(anim)
	player.coyote_buffer = 6
	if player.velocity.y < 0:
		player.sounds.play_sound("Jump")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func __physics_process(delta):
	if player.is_on_floor():
		state_machine.change_state("Idle")
		player.sounds.play_sound("Land")
	else:
		if player.test_move(player.transform, Vector2(0, 0)):
			# Floor clip exception
			player.position.y -= 1
		else:
			player.velocity.y += player.gravity * delta
	
	if player.get_jump_input_buffer(false) and player.coyote_buffer > 0 and player.velocity.y >= 0:
		player.velocity.y = player.JUMP_VELOCITY
	
	var direction = Input.get_axis("run_left", "run_right")
	if direction:
		if player.get_dash_input():
			state_machine.change_state("Dash")
		player.sprite.flip_h = direction < 0
		player.velocity.x = move_toward(player.velocity.x, direction * player.MAX_AIR_SPEED, player.AIR_ACCEL)#direction * min(player.MAX_AIR_SPEED, abs(player.velocity.x) + player.AIR_ACCEL)
	else:
		if player.get_dash_input():
			state_machine.change_state("Dash")
			# Force dash if idle
			player.velocity.x = player.sprite.scale.x * player.DASH_SPEED
		player.velocity.x = move_toward(player.velocity.x, 0, player.MAX_AIR_SPEED)
	
	player.move_and_slide()

func camera_logic():
	var cam_target_pos_x = player.CAMERA_OFFSET.x * player.velocity.x / player.MAX_RUN_SPEED
	var cam_target_pos_y = player.CAMERA_OFFSET.y * player.velocity.y / player.MAX_FALL_SPEED
	player.camera.position.x = lerpf(player.camera.position.x, cam_target_pos_x, 0.02)
	player.camera.position.y = lerpf(player.camera.position.y, cam_target_pos_y, 0.02)

func bounce(strength, dir):
	player.velocity.y = 0
	player.velocity += dir * strength
