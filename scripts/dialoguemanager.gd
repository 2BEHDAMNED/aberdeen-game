extends Node

var container : Control = null
var portrait  : TextureRect = null
var dialogue  : Label = null
var is_active : bool = false

func play_list(texts : Array):
	var index = 0
	var length = texts.size()
	for text in texts:
		index += 1
		await play_dialogue(text, index < length)

func play_dialogue(text : String, is_array: bool = false):
	if is_active:
		return
	
	if not dialogue:
		_get_dialogue()
	
	if dialogue:
		await get_tree().create_timer(1).timeout
		container.visible = true
		is_active = true
		
		dialogue.visible_characters = 0
		dialogue.text = text
		
		for i in text.length():
			dialogue.visible_characters += 1
			await get_tree().create_timer(0.05).timeout
		
		is_active = false
		await get_tree().create_timer(2).timeout
		
		# maybe wait on input instead of continuing as that makes it harder to read
		if not is_array:
			await get_tree().create_timer(2).timeout
			container.visible = false
		else:
			dialogue.visible_characters = 0

func _get_portrait():
	if not container:
		_get_container()
	portrait = get_node("/root/Node3D/ThePlayer/Control/DialogContainer/PortraitContainer/Portrait")

func _get_container():
	container = get_node("/root/Node3D/ThePlayer/Control/DialogContainer")

func _get_dialogue():
	if not container:
		_get_container()
	dialogue = get_node("/root/Node3D/ThePlayer/Control/DialogContainer/DialogueContainer/Dialogue")
	if dialogue:
		dialogue.text = ""
