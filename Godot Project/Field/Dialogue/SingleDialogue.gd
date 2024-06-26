class_name SingleDialogue extends Dialogue

@export var next: Dialogue

func has_next() -> bool:
	if next == null:
		return false
	else:
		return true
