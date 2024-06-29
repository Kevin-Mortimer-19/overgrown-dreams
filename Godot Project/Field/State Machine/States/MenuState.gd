extends PlayerState

var menu: PackedScene = null

var submenu_open: bool = false
var submenu: Control = null

signal menu_open(m: PackedScene)
signal menu_close

func update(_delta: float) -> void:
	if Input.is_action_just_pressed("pause") && submenu_open:
		close_submenu()
	elif Input.is_action_just_pressed("pause"):
		state_machine.transition_to("Walk")

func open_submenu(n: Control):
	submenu_open = true
	submenu = n
	n.visible = true

func close_submenu():
	if submenu != null:
		submenu_open = false
		submenu.visible = false
		submenu = null

func enter(_msg = {}):
	if _msg.has("Menu"):
		menu = _msg["Menu"]
		menu_open.emit(menu)
	else:
		player.get_parent().pause_menu.visible = true

func exit(_msg = {}):
	if menu != null:
		menu_close.emit()
		menu = null
	player.get_parent().pause_menu.visible = false
