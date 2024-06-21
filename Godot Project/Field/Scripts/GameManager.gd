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

func _physics_process(_delta):
	talk_check()
	pause_check()

func talk_check():
	if dialogue_open:
		if Input.is_action_just_pressed("ui_accept"):
			close_dialogue()

func pause_check():
	if Input.is_action_just_pressed("pause"):
		if paused:
			paused = false
			if gear_m_open:
				toggle_gear_menu()
			player.unlock_movement()
			pause_menu.visible = false
		elif not dialogue_open:
			paused = true
			player.lock_movement()
			pause_menu.visible = true

func save():
	Game_Data.save_game()

func toggle_gear_menu():
	if gear_m_open:
		GearMenu.visible = false
		gear_m_open = false
	else:
		GearMenu.open_menu(GearMenu.current_tab)
		GearMenu.visible = true
		gear_m_open = true
		
func toggle_shop():
	if shop.visible == true:
		shop.visible = false
	else:
		shop.visible = true

func open_dialogue(text: String):
	DialogueBox.visible = true
	DialogueBox.get_child(0).get_child(0).text = text
	dialogue_open = true
	player.lock_movement()

func close_dialogue():
	DialogueBox.visible = false
	dialogue_open = false
	player.unlock_movement()

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
	#var res1 = load("res://Field/Gear/Resource Files/Blue Gloves.tres")
	#var res2 = load("res://Field/Gear/Resource Files/Blue Hat.tres")
	#var res3 = load("res://Field/Gear/Resource Files/Blue Shirt.tres")
	#var res4 = load("res://Field/Gear/Resource Files/Red Gloves.tres")
	#var res5 = load("res://Field/Gear/Resource Files/Red Hat.tres")
	#var res6 = load("res://Field/Gear/Resource Files/Red Shirt.tres")
	#
	#GearMenu.add_gear(res1)
	#GearMenu.add_gear(res2)
	#GearMenu.add_gear(res3)
	#GearMenu.add_gear(res4)
	#GearMenu.add_gear(res5)
	#GearMenu.add_gear(res6)
	
	GearMenu.open_menu(GearMenu.current_tab)
