extends Control

@export var buttontofocusonexit : Button = null

var lastVisibleState = visible

func close_menu() -> void:
	visible = false
	buttontofocusonexit.grab_focus()

func _process(delta: float) -> void:
	if lastVisibleState != visible and visible:
		$Panel/VBoxContainer/StartGameButton.grab_focus()
	lastVisibleState = visible
	if not visible:
		pass
		
	if Input.is_action_pressed("ui_cancel"):
		close_menu()

func _on_back_button_pressed() -> void:
	close_menu()
