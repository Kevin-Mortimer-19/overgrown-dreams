extends PanelContainer

@onready var text_field = $MarginContainer/RichTextLabel

func set_text(t: Dialogue):
	text_field.text = t.text
