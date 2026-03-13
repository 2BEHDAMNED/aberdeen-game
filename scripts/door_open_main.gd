extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TheDoor.visible = true
	$TheDoor/MeshInstance3D/AnimationPlayer.animation_finished.connect(_on_animation_finished)

func _on_timer_timeout() -> void:
	remove_child($TheDoor)

func _on_animation_finished(name: String) -> void:
	var timer := Timer.new()
	add_child(timer)
	timer.wait_time = 2.5
	timer.one_shot = true
	timer.start()
	timer.timeout.connect(_on_timer_timeout)
