extends Node

# Base class for an actor in an instance of combat. Specific characters or enemies may inherit from this class
# for more unique functionality, but this class will contain all the necessary components for a functional
# entity in combat.

var attack: 
	get: return attack
var defense:
	get: return defense
var speed:
	get: return speed
var max_health:
	get: return max_health
var cur_health:
	get: return cur_health
var max_mp:
	get: return max_mp
var cur_mp:
	get: return cur_mp

func _initialize_actor(
	src_attack: int,
	src_defense: int,
	src_speed: int,
	src_max_health: int,
	src_cur_health: int,
	src_max_mp: int,
	src_cur_mp: int
	) -> void:
	attack = src_attack
	defense = src_defense
	speed = src_speed
	max_health = src_max_health
	cur_health = src_cur_health
	max_mp = src_max_mp
	cur_mp = src_cur_mp

