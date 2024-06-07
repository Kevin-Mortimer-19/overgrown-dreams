class_name UniqueItem extends Node

var item: Equipment
var amount: int

func _init(i: Equipment = null, a: int = 0):
	item = i
	amount = a

func add_item(a: int = 1):
	amount += a

func remove_item(a: int = 1):
	amount -= a
	if amount < 0:
		amount = 0

func empty():
	if amount == 0:
		return true
	else:
		return false

func has(e: Equipment):
	if e == item:
		return true
	else:
		return false
