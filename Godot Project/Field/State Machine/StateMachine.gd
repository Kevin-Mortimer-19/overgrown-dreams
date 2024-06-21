class_name StateMachine extends Node

@export var initial_state: State

@onready var current_state: State = initial_state

signal transitioned(state_name)

func _ready():
	await owner.ready
	# The state machine assigns itself to the State objects' state_machine property.
	for child in get_children():
		child.state_machine = self
	current_state.enter()

func _process(_delta: float) -> void :
	current_state.update(_delta)

func _physics_process(_delta: float) -> void :
	current_state.physics_update(_delta)


func transition_to(target_state_name: String, msg: Dictionary = {}):
	# Safety check, you could use an assert() here to report an error if the state name is incorrect.
	# We don't use an assert here to help with code reuse. 
	# If you reuse a state in different state machines but you don't want them all, 
	# they won't be able to transition to states that aren't in the scene tree.
	if not has_node(target_state_name):
		return
	
	current_state.exit()
	current_state = get_node(target_state_name)
	current_state.enter(msg)
	emit_signal("transitioned", current_state.name)
