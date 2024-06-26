extends PlayerState

func update(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		state_machine.transition_to("Walk")

func enter(_msg = {}):
	if _msg.has("NPC"):
		_msg["NPC"].talk()

func exit(_msg = {}):
	player.get_parent().close_dialogue()
