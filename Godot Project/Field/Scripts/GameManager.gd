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

func _physics_process(_delta):
	pause_check()

func pause_check():
	if Input.is_action_just_pressed("ui_accept"):
		if paused:
			paused = false
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
