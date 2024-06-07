extends Control

@export var character: CharacterData

var helm_list: Array[Equipment] = []
var shirt_list: Array[Equipment] = []
var arms_list: Array[Equipment] = []

var nogearh: Equipment = preload("res://Field/Gear/Resource Files/None1.tres")
var nogearc: Equipment = preload("res://Field/Gear/Resource Files/None2.tres")
var nogeara: Equipment = preload("res://Field/Gear/Resource Files/None3.tres")

@onready var helm_list_UI = $VBoxContainer/Helmet/OptionButton
@onready var shirt_list_UI = $VBoxContainer/Shirt/OptionButton
@onready var arms_list_UI = $VBoxContainer/Arms/OptionButton

func _ready():
	helm_list_UI.item_selected.connect(helmet_select)
	shirt_list_UI.item_selected.connect(shirt_select)
	arms_list_UI.item_selected.connect(arms_select)
	
	character.helm = nogearh
	character.shirt = nogearc
	character.gloves = nogeara

func generate_menus():
	generate_option_button(helm_list_UI, character.helm, helm_list, nogearh)
	generate_option_button(shirt_list_UI, character.shirt, shirt_list, nogearc)
	generate_option_button(arms_list_UI, character.gloves, arms_list, nogeara)

func generate_option_button(UIlist: OptionButton, current: Equipment, list: Array[Equipment], none: Equipment):
	var idx: int
	if current.equipment_name == "None":
		add_option(UIlist, current, 0)
		UIlist.selected = 0
		idx = 1
	else:
		add_option(UIlist, none, 0)
		add_option(UIlist, current, 1)
		UIlist.selected = 1
		idx = 2
	for e in list:
		add_option(UIlist, e, idx)
		idx += 1


func add_option(list, e, idx):
	list.add_item(e.equipment_name, idx)
	list.set_item_metadata(idx, e)

func wipe_menus():
	helm_list = []
	shirt_list = []
	arms_list = []
	
	helm_list_UI.clear()
	shirt_list_UI.clear()
	arms_list_UI.clear()

func helmet_select(idx: int):
	get_parent().equipment_swap(character, helm_list_UI.get_item_metadata(idx))

func arms_select(idx:int):
	get_parent().equipment_swap(character, arms_list_UI.get_item_metadata(idx))

func shirt_select(idx:int):
	get_parent().equipment_swap(character, shirt_list_UI.get_item_metadata(idx))
	

func equip():
	pass


func add_to_head_list(e:Equipment):
	helm_list.append(e)

func add_to_chest_list(e:Equipment):
	shirt_list.append(e)

func add_to_arm_list(e:Equipment):
	arms_list.append(e)
