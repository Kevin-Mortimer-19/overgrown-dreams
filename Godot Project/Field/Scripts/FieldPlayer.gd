extends CharacterBody2D

var movement_speed = 100

func _ready():
	pass

func _physics_process(_delta):
	var m = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = m * movement_speed
	move_and_slide()
