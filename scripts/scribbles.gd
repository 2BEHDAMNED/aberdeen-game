extends TextureRect

@export var textures: Array[Resource] = []
@export var timing: float = 0.5

var current_index = 0
var time = 0.0
var has_set = false
var last_time = 0.0

func _process(delta: float) -> void:
	time = (fmod(time+delta, timing))
	
	var temp_time = snapped(time, 0.1)
	
	if temp_time == timing and not has_set:
		has_set = true
		current_index += 1
	
	if last_time != temp_time:
		has_set = false
	else:
		has_set = true # this just works idk why
	
	last_time = temp_time
	
	if current_index > textures.size() - 1:
		current_index = 0
	
	texture = textures[current_index]
