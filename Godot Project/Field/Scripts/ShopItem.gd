extends Node

@onready var item_name = $Label
@onready var cost = $Label2
@onready var buy_button = $Button

@export var item: Equipment

func _ready():
	item_name.text = item.equipment_name
	cost.text = str(item.cost) + " gold"
	buy_button.pressed.connect(get_parent().get_parent().buy_item.bind(item))
