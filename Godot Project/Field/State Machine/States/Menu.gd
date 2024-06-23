extends PlayerState

var submenu_open: bool = false
var submenu: Control = null

signal menu_open
signal menu_close

func _ready():
	# The states are children of the `Player` node so their `_ready()` callback will execute first.
	# That's why we wait for the `owner` to be ready first.
	await owner.ready
	
	player = owner as FieldPlayer
	# This check will tell us if we inadvertently assign a derived state script
	# in a scene other than `Player.tscn`, which would be unintended. This can
	# help prevent some bugs that are difficult to understand.
	assert(player != null)

	menu_open.connect(open_submenu)
	menu_close.connect(close_submenu)

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
	submenu_open = false
	submenu.visible = false
	submenu = null

func enter(_msg = {}):
	player.get_parent().pause_menu.visible = true

func exit(_msg = {}):
	player.get_parent().pause_menu.visible = false
