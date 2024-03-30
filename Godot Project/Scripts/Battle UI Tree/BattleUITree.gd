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
		enemy_select = false
	previous_node()

# If there is a next node, call this function
func next_node(n: String):
	current_node = current_node.find_next(n)
	if current_node.has_next():
		focus_on_first()
	if current_node.submenu != null:
		current_node.submenu.visible = true

func previous_node():
	if current_node.previous_node != null:
		if current_node.submenu != null:
			current_node.submenu.visible = false
		current_node = current_node.previous_node
		focus_on_first()

func focus_on_first():
	current_node.find_first().button.grab_focus()

func focus_on_current():
	if current_node.button_name != "":
		current_node.button.grab_focus()

func target_selection(node_name: String):
	next_node(node_name)
	enemy_select = true

func return_to_root():
	while current_node.previous_node != null:
		previous_node()

# This function might need to be reworked at some point.
func first_layer_buttons() -> Array[Button]:
	var list : Array[Button] = []
	for i in root.next_nodes.values():
		list.append(i.button)
	return list
