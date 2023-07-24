extends CharacterBody2D

class_name Player

const MAX_AIR_SPEED = 200.0
const MAX_RUN_SPEED = 200.0
const MAX_FALL_SPEED = 100.0
const DASH_SPEED = 800.0
const DASH_DECCEL = 30.0
const AIR_ACCEL = 50.0
const RUN_ACCEL = 100.0
const STOP_DECCEL = 100.0
const JUMP_VELOCITY = -400.0
const CAMERA_OFFSET = Vector2(20, 10)

const DASH_TIME = 0.15
const DASH_COOLDOWN_TIME = 0.5

@export var sprite: AnimatedSprite2D
@export var camera: Camera2D
@export var sounds: SoundController
@export var meta: Meta
@export var killbox: Killbox
@export var state_machine: PlayerStateMachine
@export var particles: GPUParticles2D
@export var dash_particles: GPUParticles2D
@export var end_particles: GPUParticles2D
@export var ending_sprite: Sprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var coyote_buffer = 0
var jump_input_buffer = 0
var dash_cooldown = 0

@onready var spawn_point = position

func _physics_process(delta):
	if Input.is_action_just_pressed("jump"):
		jump_input_buffer = 6
	
	if Input.is_action_just_pressed("switch"):
		switch_worlds()
		
	jump_input_buffer = max(0, jump_input_buffer - 1)
	coyote_buffer = max(0, coyote_buffer - 1)
	
	# Trust me on this one
	dash_cooldown = max(0, dash_cooldown - delta)

func switch_worlds():
	var alt_world = meta.switch_worlds()
	if alt_world:
		killbox.collision_mask = 0b1000
		collision_mask = 0b10
		collision_layer = 0b1100000
	else:
		killbox.collision_mask = 0b0100
		collision_mask = 0b01
		collision_layer = 0b1010000

func get_jump_input_buffer(purge_buffer = true):
	if jump_input_buffer > 0:
		if purge_buffer:
			jump_input_buffer = 0
		return true
	return false

func get_dash_input(activate_cooldown = true):
	if Input.is_action_just_pressed("dash") and dash_cooldown <= 0:
		if activate_cooldown:
			dash_cooldown = DASH_COOLDOWN_TIME
		return true
	return false

func change_animation(anim):
	sprite.play(anim)

func kill():
	state_machine.change_state("Death")

func bounce(strength, dir):
	state_machine.bounce(strength, dir)

func ascend():
	state_machine.change_state("Ascend")

func ending():
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_EXPO)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(ending_sprite, "scale", Vector2(1000, 1000), 0.3)
	tween.tween_callback(get_tree().quit)
