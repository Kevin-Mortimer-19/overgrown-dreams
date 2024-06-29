extends VBoxContainer

var parent

@onready var gear_b = $"Gear Button"
@onready var item_b = $"Item Button"
@onready var save_b = $"Save Button"
@onready var load_b = $"Load Button"

signal save
signal load

func _ready():
	gear_b.pressed.connect(open_gear_menu)
	save_b.pressed.connect(parent_save)

func set_parent(o: Object):
	parent = o

func parent_save():
	parent.save()

func open_item_menu():
	pass

func open_gear_menu():
	parent.toggle_gear_menu()
