extends Control

@export var play_button: Button = null
@export var quit_button: Button = null
@export var cursor: Resource = null

func _on_play_button_mouse_entered() -> void:
	play_button.text = "> play"

func _on_play_button_mouse_exited() -> void:
	play_button.text = "  play"

func _on_quit_button_mouse_entered() -> void:
	quit_button.text = "> quit"

func _on_quit_button_mouse_exited() -> void:
	quit_button.text = "  quit"

func _on_play_button_pressed() -> void:
	pass

func _on_quit_button_pressed() -> void:
	get_tree().quit()
