extends PlayerState

func update(_delta: float) -> void:
	player.move()
	if Input.is_action_just_pressed("pause"):
		state_machine.transition_to("Menu")
	elif Input.is_action_just_pressed("ui_accept"):
		print ("If I were an NPC, I'd talk your ear off right about now!")

func enter(_msg = {}):
	player.movement_locked = false

func exit(_msg = {}):
	player.movement_locked = true
