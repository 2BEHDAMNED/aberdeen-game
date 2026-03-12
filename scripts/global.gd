extends Node

var g_path = ""

func goto_scene(path: String) -> void:
	g_path = ""
	_deferred_goto_scene.call_deferred(path)

func goto_scene_via_door(path: String) -> void:
	g_path = path
	_deferred_goto_scene.call_deferred("res://scenes/door_open.tscn", true)

func _child_exiting_tree(node: Node) -> void:
	if node.name == "TheDoor":
		_deferred_goto_scene.call_deferred(g_path)
		g_path = ""

func _deferred_goto_scene(path: String, door: bool = false) -> void:
	get_tree().current_scene.free()
	
	var packed_scene: PackedScene = ResourceLoader.load(path)
	var instanced_scene := packed_scene.instantiate()
	
	get_tree().root.add_child(instanced_scene)
	get_tree().current_scene = instanced_scene
	
	if door:
		instanced_scene.child_exiting_tree.connect(_child_exiting_tree)
