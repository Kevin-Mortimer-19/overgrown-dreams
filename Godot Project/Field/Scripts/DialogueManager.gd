extends PanelContainer

@onready var text_field = $MarginContainer/RichTextLabel
@onready var choice_box = get_node("/root/Town/DialogueChoices")

signal advance(d: Dialogue)
signal approaching_menu

var current_line: Dialogue

func set_dialogue(d: Dialogue):
	clear_choices()
	self.visible = true
	current_line = d
	if current_line is SingleDialogue:
		# Display text
		set_text(d.text)
		advance.emit(current_line)
	elif current_line is ChoiceDialogue:
		# Display text and choices and wait for input
		set_text(d.text)
		for c in d.choices:
			var db = DialogueButton.new(c)
			db.info = c
			choice_box.add_child(db)
			db.pressed.connect(set_dialogue.bind(db.info.next))
		choice_box.visible = true
		advance.emit(current_line)
	elif current_line is MenuDialogue:
		if current_line.prior_text_box:
			# Display text if necessary
			set_text(d.text)
			approaching_menu.emit()
		advance.emit(current_line)

func clear_choices():
	for c in choice_box.get_children():
		c.queue_free()

func set_text(t: String):
	text_field.text = t
