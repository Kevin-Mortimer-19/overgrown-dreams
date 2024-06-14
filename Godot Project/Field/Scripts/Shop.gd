extends PanelContainer

@onready var goldcount = $VBoxContainer/HBoxContainer/GoldAmount

func buy_item(item: Equipment):
	if get_parent().buy_gear(item):
		update_gold(get_parent().get_gold())

func update_gold(amount: int):
	goldcount.text = str(amount) + " gold"
