class_name NPC extends StaticBody2D

@export var default_dialogue: Dialogue

signal speak(dialogue)

func talk():
	speak.emit(default_dialogue)
