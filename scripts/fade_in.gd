extends Control

@export var multiplier: float = 0.05

var alpha = 1.0
func _ready() -> void:
	if not visible:
		visible = true

func _process(delta: float) -> void:
	if alpha > 0:
		alpha -= 1*delta*multiplier
		
		$ColorRect.modulate.a = alpha
