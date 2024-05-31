extends Control

@export var c: CharacterData

var helm_list: Array[Equipment] = []
var shirt_list: Array[Equipment] = []
var arms_list: Array[Equipment] = []

@onready var helm_list_UI = $VBoxContainer/Helmet/OptionButton
@onready var shirt_list_UI = $VBoxContainer/Shirt/OptionButton
@onready var arms_list_UI = $VBoxContainer/Arms/OptionButton


func generate_menus():
	var idx = 0
	for e in helm_list:
		helm_list_UI.add_item(e.equipment_name, idx)
		helm_list_UI.set_item_metadata(idx, e)
		idx += 1
	idx = 0
	for e in shirt_list:
		shirt_list_UI.add_item(e.equipment_name, idx)
		shirt_list_UI.set_item_metadata(idx, e)
		idx += 1
	idx = 0
	for e in arms_list:
		arms_list_UI.add_item(e.equipment_name, idx)
		arms_list_UI.set_item_metadata(idx, e)
		idx += 1

func add_to_head_list(e:Equipment):
	helm_list.append(e)

func add_to_chest_list(e:Equipment):
	shirt_list.append(e)

func add_to_arm_list(e:Equipment):
	arms_list.append(e)
