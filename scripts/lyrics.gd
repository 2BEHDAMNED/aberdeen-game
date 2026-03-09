extends Label

@export var bgm : AudioStreamPlayer = null

var lyrics = [
	[20.5, "you'd rather live"],
	[24.0, "to please"],
	[26.5, ""],
	[31.5, "and die a virgin"],
	[36.5, ""],
	[40.0, "said you wanna"],
	[41.5, "go"],
	[43.0, "see the world"],
	[47.0, ""],
	[51.0, "but you're"],
	[53.0, "stuck"],
	[56.0, "at work"],
	[58.5, ""],
	[71.0, "if you could go anywhere"],
	[74.0, "where would you go?"],
	[76.0, "if you could go anywhere"],
	[79.0, "where would you go?"],
	[81.0, "if you could go anywhere"],
	[83.6, "would you"],
	[85.0, "stay"],
	[86.5, "here?"],
	[88.5, ""],
	[91.0, "if you could go anywhere"],
	[93.5, "where would you go?"],
	[96.0, "if you could go anywhere"],
	[98.5, "where would you go?"],
	[101.0, "if you could go anywhere"],
	[103.6, "would you"],
	[104.6, "stay?"],
	[110.0, ""]
]

var currentIndex = 0
var currentTimePosition = 0.0

func _ready() -> void:
	visible = false
	bgm.finished.connect(_reset)

func _reset():
	currentIndex = 0
	visible = false

func _process(delta: float) -> void:
	if currentTimePosition > bgm.get_playback_position(): 
		_reset()
	
	currentTimePosition = bgm.get_playback_position()
	
	if currentIndex < lyrics.size():
		if lyrics[currentIndex][0] <= bgm.get_playback_position():
			if not visible and lyrics[currentIndex][1] != "":
				visible = true
			else:
				if lyrics[currentIndex][1] == "":
					visible = false
			
			text = lyrics[currentIndex][1]
			currentIndex += 1
