class_name BattleUITreeNode extends Node

@export var previous_node: BattleUITreeNode

#@export var next_nodes: Array[BattleUITreeNode] = []

var next_nodes = {}

@export var target: Data.BattleTargets

var button_name: String

var button: Button

func _init(b_name: String = "", previous: BattleUITreeNode = null, next: Dictionary = {}, t: Data.BattleTargets = 0):
	button_name = b_name
	previous_node = previous
	next_nodes = next
	target = t
	button = Button.new()
	button.text = button_name
	button.size_flags_vertical = Control.SIZE_EXPAND_FILL

func find_next(node_name: String)-> BattleUITreeNode:
	return next_nodes[node_name]

func append_next(next: BattleUITreeNode):
	next_nodes[next.button_name] = next
	#next_nodes.append(next)

func cancel():
	pass
