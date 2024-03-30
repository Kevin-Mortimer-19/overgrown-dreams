class_name BattleUINode extends Node

@export var previous_node: BattleUINode

#@export var next_nodes: Array[BattleUINode] = []

var next_nodes = {}

var submenu: BoxContainer

@export var target: Data.BattleTargets

var button_name: String

var button: Button

func _init(b_name: String = "", previous: BattleUINode = null, next: Dictionary = {}, t: Data.BattleTargets = Data.BattleTargets.NONE, sub = null):
	button_name = b_name
	previous_node = previous
	next_nodes = next
	target = t
	button = Button.new()
	button.text = button_name
	button.size_flags_vertical = Control.SIZE_EXPAND_FILL
	submenu = sub

func find_next(node_name: String)-> BattleUINode:
	return next_nodes[node_name]

func find_first() -> BattleUINode:
	if next_nodes != null:
		var v = next_nodes.values()
		return v[0]
	else:
		return null

func find_all_next()-> Array[BattleUINode]:
	var list : Array[BattleUINode] = []
	for i in next_nodes.values():
		list.append(i)
	return list

func append_next(next: BattleUINode):
	next_nodes[next.button_name] = next
	#next_nodes.append(next)

# BE VERY CAREFUL WITH THIS
func remove_all_next():
	next_nodes = {}

func has_next()-> bool:
	return !next_nodes.is_empty()
