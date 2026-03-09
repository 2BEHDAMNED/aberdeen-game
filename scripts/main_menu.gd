extends Control

@export var fade_out: ColorRect = null
@export var background_music: AudioStreamPlayer = null
@export var play_menu: Control  = null

var transitioning = false
var alphaShit = 0
var currentAction = null
var alphaMultiplier = 0.25

func _ready() -> void:
	$MainMenuControls/PlayButton.grab_focus()
	play_menu.visible = false

func _process(delta: float) -> void:
	if transitioning and fade_out.visible:
		if alphaShit < 1.0:
			alphaShit += 1*delta*alphaMultiplier
			background_music.volume_db -= 10*delta
			fade_out.modulate.a = alphaShit
		else:
			if currentAction == "quit":
				get_tree().quit()
			else:
				action_change_scene()

func transition(action, multiplier = 0.25) -> void:
	if transitioning:
		pass
	
	transitioning = true
	fade_out.visible = true
	currentAction = action
	alphaMultiplier = multiplier

func action_change_scene() -> void:
	get_tree().change_scene_to_file("res://scenes/intro.tscn")

func _on_play_button_pressed() -> void:
	play_menu.visible = true
	pass

func _on_quit_button_pressed() -> void:
	transition("quit", 0.4)

func _on_start_game_button_pressed() -> void:
	transition("play")
