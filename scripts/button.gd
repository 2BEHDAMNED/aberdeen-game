extends Button

@export var textEffects  = true
@export var soundEffects = true
@export var soundOnExit  = false
@export var textPrefix   = ">"

var hover_sound   : AudioStream       = preload("res://sounds/menu_select.mp3")
var dehover_sound : AudioStream       = preload("res://sounds/menu_deselect.mp3")
var enter_sound   : AudioStream       = preload("res://sounds/menu_enter.mp3")
var soundPlayer   : AudioStreamPlayer = AudioStreamPlayer.new()
var original_text : String            = text

func _ready():
	# setup soundsystem (clickies!!!)
	if soundEffects:
		add_child(soundPlayer)
		var poly_stream: = AudioStreamPolyphonic.new()
		poly_stream.polyphony = 100
		soundPlayer.stream = poly_stream
		soundPlayer.play()
	
	# setup signals
	mouse_entered.connect(_on_mouse_enter)
	mouse_exited.connect(_on_mouse_exit)
	focus_entered.connect(_on_enter)
	focus_exited.connect(_on_exit)
	pressed.connect(_on_pressed)
	
	if textEffects:
		if not original_text.begins_with("  "):
			text = "  " + original_text

func play_sound(stream: AudioStream, volume: float = -10.0) -> void:
	if soundEffects:
		soundPlayer.get_stream_playback().play_stream(stream, 0.0, volume)

func _on_enter() -> void:
	if textEffects:
		text = textPrefix+" " + original_text
	play_sound(hover_sound)

func _on_mouse_enter() -> void:
	_on_enter()
	grab_focus()

func _on_exit():
	if textEffects:
		text = "  " + original_text
	if soundOnExit:
		play_sound(hover_sound)

func _on_mouse_exit() -> void:
	_on_exit()
	grab_focus(true)

func _on_pressed() -> void:
	play_sound(enter_sound,-5.0)
