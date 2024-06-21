extends PlayerState

func update(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		state_machine.transition_to("Walk")
