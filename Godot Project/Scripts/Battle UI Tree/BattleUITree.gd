class_name BattleUITree extends Node

var root : BattleUINode

var current_node: BattleUINode

var enemy_select: bool

func _init(r: BattleUINode = BattleUINode.new()):
	root = r
	current_node = root
	enemy_select = false

func cancel():
	if enemy_select:
		focus_on_current()
	else:
		previous_node()


func accept():
	pass

# If there is a next node, call this function
func next_node(n: String):
	current_node = current_node.find_next(n)
	if current_node.submenu != null:
			current_node.submenu.visible = true
	focus_on_current()

func previous_node():
	if current_node.previous_node != null:
		current_node = current_node.previous_node
		if current_node.submenu != null:
			current_node.submenu.visible = false
		focus_on_current()

func focus_on_current():
	if current_node.button_name != "":
		current_node.button.grab_focus()

func return_to_root():
	while current_node.previous_node != null:
		previous_node()

# This function might need to be reworked at some point.
func first_layer_buttons() -> Array[Button]:
	var list : Array[Button] = []
	for i in root.next_nodes.values():
		list.append(i.button)
	return list
