extends PlayerState

var dash_time = 0
var ground_dash = false

func _enter():
	player = state_machine.player
	player.change_animation(anim)
	dash_time = player.DASH_TIME
	player.velocity.x = sign(player.velocity.x) * player.DASH_SPEED
	player.sounds.play_sound("Dash")
	player.dash_particles.scale.x = -sign(player.velocity.x)
	player.dash_particles.emitting = true

func __physics_process(delta):
	if player.get_jump_input_buffer() and player.is_on_floor():
		player.velocity.y = player.JUMP_VELOCITY
		state_machine.change_state("Jump")
		return
	
	dash_time = max(0, dash_time - delta)
	if dash_time <= 0:
		if player.is_on_floor():
			state_machine.change_state("Run")
		else:
			state_machine.change_state("Jump")
			player.coyote_buffer = 0
	player.velocity.y = 0
	player.velocity.x -= sign(player.velocity.x) * player.DASH_DECCEL

	player.move_and_slide()

func camera_logic():
	var cam_target_pos = player.CAMERA_OFFSET.x * player.velocity.x / player.MAX_RUN_SPEED
	player.camera.position.x = lerpf(player.camera.position.x, cam_target_pos, 0.04)
	player.camera.position.y = lerpf(player.camera.position.y, 0, 0.04)

func bounce(strength, dir):
	player.velocity.y = 0
	player.velocity += dir * strength
	state_machine.change_state("Jump")
