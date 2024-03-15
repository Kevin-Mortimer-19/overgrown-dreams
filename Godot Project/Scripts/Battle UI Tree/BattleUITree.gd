class_name BattleUITree extends Node

var root

var current_node

func init(r: BattleUITreeNode = BattleUITreeNode.new()):
	root = r
	current_node = root

func cancel():
	pass

func accept():
	pass

func first_layer_buttons() -> Array[Button]:
	var list : Array[Button] = []
	for i in root.next_nodes.values():
		list.append(i.button)
	return list
