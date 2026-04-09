extends Node

@export var sprites : Array[AnimatedSprite2D] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for sprite in sprites:
		sprite.play()
