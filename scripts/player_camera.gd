extends Camera3D

@onready var flashlight := $SpotLight3D
@export  var animator   : AnimationPlayer = null
@export  var phone      : TextureRect     = null

@export var flashlight_turn_on_sound  : AudioStream = null
@export var flashlight_turn_off_sound : AudioStream = null

@onready var flashlight_sound = $AudioStreamPlayer

func _ready() -> void:
	phone.visible = flashlight_on()

func _input(event: InputEvent) -> void:
	if event.is_action("flashlight") and event.is_pressed():
		_toggle_flashlight()

func _toggle_flashlight():
	if animator.is_playing():
		return
	
	if flashlight_on():
		animator.play("phone_pulldown")
	else:
		animator.play("phone_pullup")

func flashlight_on() -> bool:
	return flashlight.visible

func _turn_on_flashlight():
	if flashlight_on():
		return
	flashlight.visible = true
	flashlight_sound.stream = flashlight_turn_off_sound
	flashlight_sound.play()

func _turn_off_flashlight():
	if not flashlight_on():
		return
	flashlight.visible = false
	flashlight_sound.stream = flashlight_turn_on_sound
	flashlight_sound.play()
