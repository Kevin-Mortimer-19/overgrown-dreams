extends NPC

var hello = "Welcome to the shop!"

func talk():
	get_parent().open_dialogue(hello)

