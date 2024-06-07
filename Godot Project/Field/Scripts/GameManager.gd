extends Node2D

@onready var player = get_node("Player/CharacterBody2D")
@onready var pause_menu = get_node("PauseMenu")

var Game_Data: GameData = load("res://Field/Resources/GameData.tres")

@onready var GearMenu = $GearMenu2

var paused: bool
var gear_m_open: bool

func _ready():
	pause_menu.set_parent(self)
	paused = false
	initialize_test_gear()

func _physics_process(_delta):
	pause_check()

func pause_check():
	if Input.is_action_just_pressed("pause"):
		if paused:
			paused = false
			if gear_m_open:
				toggle_gear_menu()
			player.unlock_movement()
			pause_menu.visible = false
		else:
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
		GearMenu.visible = true
		gear_m_open = true


func initialize_test_gear():
	var res1 = load("res://Field/Gear/Resource Files/Blue Gloves.tres")
	var res2 = load("res://Field/Gear/Resource Files/Blue Hat.tres")
	var res3 = load("res://Field/Gear/Resource Files/Blue Shirt.tres")
	var res4 = load("res://Field/Gear/Resource Files/Red Gloves.tres")
	var res5 = load("res://Field/Gear/Resource Files/Red Hat.tres")
	var res6 = load("res://Field/Gear/Resource Files/Red Shirt.tres")
	
	GearMenu.add_gear(res1)
	GearMenu.add_gear(res2)
	GearMenu.add_gear(res3)
	GearMenu.add_gear(res4)
	GearMenu.add_gear(res5)
	GearMenu.add_gear(res6)
	
	GearMenu.open_menu(GearMenu.current_tab)
