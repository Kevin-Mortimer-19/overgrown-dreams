extends VBoxContainer

var parent

@onready var gear_b = $"Gear Button"
@onready var item_b = $"Item Button"
@onready var save_b = $"Save Button"
@onready var load_b = $"Load Button"

signal save
signal load

func _ready():
	save_b.pressed.connect(parent_save)

func set_parent(o: Object):
	parent = o

func parent_save():
	parent.save()
