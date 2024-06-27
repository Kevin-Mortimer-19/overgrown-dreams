extends PanelContainer

@onready var text_field = $MarginContainer/RichTextLabel
@onready var choice_box = get_node("/root/Town/DialogueChoices")

signal advance

signal end

var current_line: Dialogue

func set_dialogue(d: Dialogue):
	clear_choices()
	self.visible = true
	current_line = d
	if current_line is SingleDialogue:
		print("SingleDialogue")
		# Display text and wait for input
		set_text(d.text)
	elif current_line is ChoiceDialogue:
		# Display text and choices and wait for input
		print("ChoiceDialogue")
		set_text(d.text)
		for c in d.choices:
			var db = DialogueButton.new(c)
			db.info = c
			choice_box.add_child(db)
			#db.pressed.connect()
	elif current_line is MenuDialogue:
		print("MenuDialogue")
		if current_line.prior_text_box:
			# Display text and wait for input to display menu
			set_text(d.text)
		else:
			# Display menu
			pass

func clear_choices():
	for c in choice_box.get_children():
		c.queue_free()

func advance_dialogue():
	advance.emit()
	set_dialogue(current_line.next)

func set_text(t: String):
	text_field.text = t
