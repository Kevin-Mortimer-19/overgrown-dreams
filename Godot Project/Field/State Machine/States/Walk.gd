extends PlayerState

func _ready():
	# The states are children of the `Player` node so their `_ready()` callback will execute first.
	# That's why we wait for the `owner` to be ready first.
	await owner.ready
	
	player = owner as FieldPlayer
	# This check will tell us if we inadvertently assign a derived state script
	# in a scene other than `Player.tscn`, which would be unintended. This can
	# help prevent some bugs that are difficult to understand.
	assert(player != null)

	player.enter_dialogue.connect(open_dialogue)

func update(_delta: float) -> void:
	player.move()
	if Input.is_action_just_pressed("pause"):
		state_machine.transition_to("Menu")
	#elif Input.is_action_just_pressed("ui_accept"):
		#print ("If I were an NPC, I'd talk your ear off right about now!")

func open_dialogue(n: StaticBody2D):
	state_machine.transition_to("Dialogue", {"NPC" : n})

func enter(_msg = {}):
	player.movement_locked = false

func exit(_msg = {}):
	player.movement_locked = true
