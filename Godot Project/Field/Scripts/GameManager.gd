extends Node2D

@onready var player = get_node("Player")
@onready var pause_menu = get_node("PauseMenu")

var Game_Data: GameData = load("res://Field/Resources/GameData.tres")

@onready var GearMenu = $GearMenu2
@onready var DialogueBox = $DialogueManager

var currently_open_menu


func _ready():
	pause_menu.set_parent(self)
	initialize_test_gear()
	var dialogue_state = player.find_state("Dialogue")
	dialogue_state.next_line.connect(open_dialogue)
	
	var menu_state = player.find_state("Menu")
	menu_state.menu_open.connect(open_menu)
	menu_state.menu_close.connect(close_menu)
	
	DialogueBox.advance.connect(dialogue_state.check_dialogue_UI)
	DialogueBox.approaching_menu.connect(dialogue_state.read_prior_message)
	#DialogueBox.advance.connect()
	# Necessary??? ^^

func _physics_process(_delta):
	pass

func save():
	Game_Data.save_game()

func toggle_gear_menu():
	get_node("Player/StateMachine/Menu").open_submenu(GearMenu)

func open_dialogue(d: Dialogue):
	DialogueBox.visible = true
	DialogueBox.set_dialogue(d)

func close_dialogue():
	DialogueBox.visible = false

func initialize_blacksmith_shop():
	var g = player.gold

func open_menu(m: PackedScene):
	currently_open_menu = m.instantiate()
	add_child(currently_open_menu)

func close_menu():
	currently_open_menu.queue_free()

func buy_gear(gear: Equipment) -> bool:
	if player.spend(gear.cost):
		GearMenu.add_gear(gear)
		return true
	else:
		return false

func get_gold():
	return player.gold

func initialize_test_gear():
	GearMenu.open_menu(GearMenu.current_tab)
