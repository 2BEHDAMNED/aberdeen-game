extends Control

@export var textures: Array[Array] = []

var current_index = 0
var time = 0.0
var has_set = false
var last_time = 0.0

var alpha = 0
var scribbles_setin = false
var click_sound   : AudioStream       = preload("res://sounds/SWITCH3.mp3")
var soundPlayer   : AudioStreamPlayer = AudioStreamPlayer.new()

func play_sound(stream: AudioStream = click_sound, volume: float = -10.0) -> void:
	soundPlayer.get_stream_playback().play_stream(stream, 0.0, volume)

func _ready():
	# setup soundsystem (clickies!!!)
	add_child(soundPlayer)
	var poly_stream: = AudioStreamPolyphonic.new()
	poly_stream.polyphony = 2
	soundPlayer.stream = poly_stream
	soundPlayer.play()
	
	$ScribblesRect.modulate.a = 0

func _process(delta: float) -> void:
	if not $FramesRect.visible and current_index == 0:
		if alpha < 12.0/256.0:
			alpha += 1*delta*0.005
			$ScribblesRect.modulate.a = alpha
		else:
			play_sound()
			scribbles_setin = true
			$FramesRect.visible = true
	else:
		if $FramesRect.visible:
			var timing = textures[current_index][0]
			time = (fmod(time+delta, timing))
			
			var temp_time = snapped(time, 0.1)
			
			if temp_time == timing and not has_set:
				play_sound()
				has_set = true
				current_index += 1
				time = 0
			
			if last_time != temp_time:
				has_set = false
			else:
				has_set = true # this just works idk why
			
			last_time = temp_time
			
			if current_index > textures.size() - 1:
				play_sound()
				$FramesRect.visible = false
				$ScribblesRect.visible = false
				$AudioStreamPlayer.stop()
			else:
				$FramesRect.texture = textures[current_index][1]
