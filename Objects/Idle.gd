extends PlayerState

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func __physics_process(_delta):
	if !player.is_on_floor():
		state_machine.change_state("Jump")
	
	if player.get_dash_input():
		# Force dash
		player.velocity.x = (-1 if player.sprite.flip_h else 1) * player.DASH_SPEED
		state_machine.change_state("Dash")
	
	if player.get_jump_input_buffer():
		player.velocity.y = player.JUMP_VELOCITY
	
	var direction = Input.get_axis("run_left", "run_right")
	if direction:
		state_machine.change_state("Run")
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.STOP_DECCEL)# sign(player.velocity.x) * max(0, (abs(player.velocity.x) - player.STOP_DECCEL))
	
	player.move_and_slide()

func camera_logic():
	var cam_target_pos = player.CAMERA_OFFSET.x * player.velocity.x / player.MAX_RUN_SPEED
	player.camera.position.x = lerpf(player.camera.position.x, cam_target_pos, 0.06)
	player.camera.position.y = lerpf(player.camera.position.y, 0, 0.04)

func bounce(strength, dir):
	player.velocity.y = 0
	player.velocity += dir * strength
