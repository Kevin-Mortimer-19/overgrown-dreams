class_name FieldPlayer extends CharacterBody2D

var movement_speed = 100

var movement_locked: bool

var gold: int = 500

@onready var state_machine = $StateMachine

signal enter_dialogue(body: StaticBody2D)

func _ready():
	movement_locked = false

func _physics_process(_delta):
	#move()
	pass

func move():
	var m = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if not movement_locked:
		velocity = m * movement_speed
		var c = move_and_slide()
		if c:
			var c2 = get_last_slide_collision()
			if c2.get_collider().is_in_group("NPC") and Input.is_action_just_pressed("ui_accept"):
				enter_dialogue.emit(c2.get_collider())

func lock_movement():
	movement_locked = true

func unlock_movement():
	call_deferred("unlock_movement_real")

func unlock_movement_real():
	movement_locked = false

func spend(value: int) -> bool:
	var g = gold - value
	if g >= 0:
		gold = g
		return true
	else:
		return false

func find_state(s: String) -> PlayerState:
	return state_machine.get_node(s)
