class_name Actor extends Node

# Base class for an actor in an instance of combat. Specific characters or enemies may inherit from this class
# for more unique functionality, but this class will contain all the necessary components for a functional
# entity in combat.

var stats: Stats
var ui_button: Button

var sm: StatusManager

signal death

var defending: bool = false

func _init(src_stats: Stats = Stats.new(), src_button: Button = Button.new()):
	stats = src_stats
	ui_button = src_button
	sm = StatusManager.new()
	death.connect(func():print(stats.actor_name + " is dead!"))

func start_of_turn():
	if defending:
		defending = false

func take_damage(val):
	if defending:
		stats.cur_hp -= (val/2)
		defending = false
	else:
		stats.cur_hp -= val
	if stats.cur_hp <= 0:
		death.emit()

func heal(val):
	stats.cur_health += val
	if stats.cur_health > stats.max_health:
		stats.cur_health = stats.max_health

func _initialize_actor(src_stats: Stats) -> void:
	stats = src_stats
	death.connect(func():print(stats.actor_name + " is dead!"))

func add_status(s: StatusData):
	sm.add_status(s)

func status_check():
	sm.end_of_turn()

func defend():
	defending = true
