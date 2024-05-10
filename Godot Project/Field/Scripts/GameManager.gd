extends Node2D

@onready var player = get_node("Player/CharacterBody2D")
@onready var pause_menu = get_node("PauseMenu")

#var Game_Data = load("res://Field/Resources/GameData.tres")

var paused: bool

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
	pass
	#Game_Data.save()
