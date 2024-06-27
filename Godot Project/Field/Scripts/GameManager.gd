extends Node2D

@onready var player = get_node("Player")
@onready var pause_menu = get_node("PauseMenu")

var Game_Data: GameData = load("res://Field/Resources/GameData.tres")

@onready var GearMenu = $GearMenu2
@onready var DialogueBox = $DialogueManager
@onready var shop = $BlacksmithShop

var paused: bool
var gear_m_open: bool
var dialogue_open: bool



func _ready():
	pause_menu.set_parent(self)
	paused = false
	dialogue_open = false
	initialize_test_gear()
	var dialogue_state = get_node("Player/StateMachine/Dialogue")
	dialogue_state.next_line.connect(open_dialogue)
	#DialogueBox.advance.connect()
	# Necessary??? ^^

func _physics_process(_delta):
	pass

func save():
	Game_Data.save_game()

func toggle_gear_menu():
	get_node("Player/StateMachine/Menu").open_submenu(GearMenu)

func toggle_shop():
	if shop.visible == true:
		shop.visible = false
	else:
		shop.visible = true

func open_dialogue(d: Dialogue):
	DialogueBox.visible = true
	DialogueBox.set_dialogue(d)
	#dialogue_open = true
	#player.lock_movement()

func advance_dialogue():
	pass

func close_dialogue():
	DialogueBox.visible = false
	
	#dialogue_open = false
	#player.unlock_movement()

func initialize_blacksmith_shop():
	var g = player.gold

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
