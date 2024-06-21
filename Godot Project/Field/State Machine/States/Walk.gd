extends PlayerState

func update(_delta: float) -> void:
	player.move()
	if Input.is_action_just_pressed("ui_cancel"):
		state_machine.transition_to("Menu")
	elif Input.is_action_just_pressed("ui_cancel"):
		print ("If I were an NPC, I'd talk your ear off right about now!")
