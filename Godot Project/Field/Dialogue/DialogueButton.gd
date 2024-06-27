class_name DialogueButton extends Button

var info: DialogueOption

func _init(d: DialogueOption = DialogueOption.new()):
	info = d

func _ready():
	if info != null:
		text = info.text
	#pressed.connect()
