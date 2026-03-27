extends CharacterBody3D


const WALKSPEED = 5.0
const RUNSPEED = 7.5
const JUMP_VELOCITY = 4.5
const SENSITIVITY = 0.003
const GAMEPAD_SENS = 0.3

@onready var head : Node3D = $Head
@onready var camera := $Head/Camera
@onready var walking_sound := $AudioStreamPlayer

var gamepad_enabled = false
var is_walking = false
var sprinting = false

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	DialogueManager.play_list(['Hello', 'This is a test', 'Does this work?', 'Vic Hello?'])

func _input(event:InputEvent) -> void:
	if event is InputEventMouseMotion:
		gamepad_enabled = false
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
	
	
	gamepad_enabled = event is InputEventJoypadButton or event is InputEventJoypadMotion
	if gamepad_enabled:
		$Control/Label.text = "INPUT: GAMEPAD"
	else:
		$Control/Label.text = "INPUT: KEYBOARD"



func _process(delta: float) -> void:
	if gamepad_enabled:
		var cam_axis := Input.get_vector("camera_left", "camera_right", "camera_up", "camera_down")
		head.rotate_y(deg_to_rad(-cam_axis.x * 1.5))
		camera.rotate_x(deg_to_rad(-cam_axis.y * 1.5))
	camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(60))
	
	if Input.is_action_just_pressed("sprint"):
		sprinting = not sprinting
	
	if not sprinting:
		walking_sound.pitch_scale = 0.75
	else:
		walking_sound.pitch_scale = 1.25
	
	if is_walking and not walking_sound.playing:
		walking_sound.play()
	else:
		if not is_walking:
			walking_sound.stop()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	var input_dir := Input.get_vector("player_strafe_left", "player_strafe_right", "player_forwards", "player_backwards")
	var direction := (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	is_walking = direction.length() != 0.0
	
	var SPEED = WALKSPEED
	if sprinting:
		SPEED = RUNSPEED
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	move_and_slide()
