extends Node

var container : Control = null
var portrait  : TextureRect = null
var dialogue  : Label = null
var enterquery: Label = null
var is_active : bool = false
var is_active_array = false

signal continue_going

func play_list(texts : Array):
	var index = 0
	var length = texts.size()
	for text in texts:
		index += 1
		await play_dialogue(text, index < length)

func play_dialogue(text : String, is_array: bool = false):
	if is_active:
		return
	
	if is_array != is_active_array:
		is_active_array = is_array
	
	if not dialogue:
		_get_dialogue()
	
	if dialogue:
		container.visible = true
		is_active = true
		
		dialogue.visible_characters = 0
		dialogue.text = text
		
		for i in text.length():
			dialogue.visible_characters += 1
			await get_tree().create_timer(0.05).timeout
		
		
		await get_tree().create_timer(1).timeout
		var in_the_middle_of_something = false
		
		continue_going.connect(func(is_array: bool):
			if not is_active:
				return
			
			if in_the_middle_of_something:
				return
			
			in_the_middle_of_something = true
			if not is_array:
				container.visible = false
			else:
				dialogue.visible_characters = 0
			is_active = false
		)
		
		while is_active:
			if not enterquery.visible:
				enterquery.visible = true
			await get_tree().create_timer(0.001).timeout
		
		enterquery.visible = false

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("ui_accept") and is_active:
		continue_going.emit(is_active_array)

func _get_portrait():
	if not container:
		_get_container()
	portrait = get_node("/root/Node3D/ThePlayer/Control/DialogContainer/PortraitContainer/Portrait")

func _get_container():
	container = get_node("/root/Node3D/ThePlayer/Control/DialogContainer")

func _get_enterquery():
	enterquery = get_node("/root/Node3D/ThePlayer/Control/DialogContainer/DialogueContainer/PressEnter")

func _get_dialogue():
	if not container:
		_get_container()
	if not enterquery:
		_get_enterquery()
	
	dialogue = get_node("/root/Node3D/ThePlayer/Control/DialogContainer/DialogueContainer/Dialogue")
	if dialogue:
		dialogue.text = ""
