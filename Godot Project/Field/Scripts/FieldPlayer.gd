extends CharacterBody2D

var movement_speed = 100

var movement_locked: bool

func _ready():
	movement_locked = false

func _physics_process(_delta):
	var m = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if not movement_locked:
		velocity = m * movement_speed
		move_and_slide()

func lock_movement():
	movement_locked = true

func unlock_movement():
	movement_locked = false
