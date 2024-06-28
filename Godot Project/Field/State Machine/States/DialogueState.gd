extends PlayerState

var current_line: Dialogue

signal next_line(d: Dialogue)

# Marks whether or not the state is in a prior text box for a menu dialogue line
var reading_prior_message: bool = false

func update(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") and can_advance():
		advance()

func can_advance() -> bool:
	if current_line is SingleDialogue or (current_line is MenuDialogue and reading_prior_message):
		return true
	else:
		return false

func advance():
	if current_line is SingleDialogue:
		if not current_line.has_next():
			call_deferred("end_dialogue")
		current_line = current_line.next
		next_line.emit(current_line)
	elif current_line is MenuDialogue and reading_prior_message:
		reading_prior_message = false
		state_machine.transition_to("Menu", {"Menu" : current_line.menu})

func read_prior_message():
	reading_prior_message = true

func end_dialogue():
	state_machine.transition_to("Walk")

func check_dialogue_UI(d: Dialogue):
	if d != current_line:
		current_line = d

func enter(_msg = {}):
	if _msg.has("NPC"):
		current_line = _msg["NPC"].default_dialogue
	next_line.emit(current_line)

func exit(_msg = {}):
	player.get_parent().close_dialogue()
