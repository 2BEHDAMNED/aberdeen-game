extends TextureButton

@export var title : String = ""
@export var scene : Node2D = null
@export var scene_to_go_to : Node2D = null

var label : Label = null

func _ready() -> void:
	label = get_parent().find_child("Label")
	pressed.connect(_on_pressed)
	mouse_entered.connect(_on_mouse_enter)
	mouse_exited.connect(_on_mouse_exit)

func _on_mouse_enter():
	if label:
		label.text = title

func _on_mouse_exit():
	if label:
		label.text = ""

func _on_pressed():
	print("my name is: " + name)
	if scene and scene_to_go_to:
		scene.visible = false
		scene_to_go_to.visible = true
