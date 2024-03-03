class_name Actor extends Node

# Base class for an actor in an instance of combat. Specific characters or enemies may inherit from this class
# for more unique functionality, but this class will contain all the necessary components for a functional
# entity in combat.

var stats: Stats

signal death

func take_damage(val):
	stats.cur_health -= val
	if stats.cur_health <= 0:
		death.emit()

func heal(val):
	stats.cur_health += val
	if stats.cur_health > stats.max_health:
		stats.cur_health = stats.max_health

func _initialize_actor(src_stats: Stats) -> void:
	stats = src_stats

