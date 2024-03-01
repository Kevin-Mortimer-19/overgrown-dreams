class_name Actor extends Node

# Base class for an actor in an instance of combat. Specific characters or enemies may inherit from this class
# for more unique functionality, but this class will contain all the necessary components for a functional
# entity in combat.

# Battle statistics:
# Attack is how much damage the Actor deals
var attack: int:
	get: return attack
# Incoming attack damage is mitigated by defense
var defense: int:
	get: return defense
# Speed determines turn order; the higher an actor's speed, the earlier they will act
var speed: int:
	get: return speed
# Mamy skills scale off an Actor's spirit, and are more effective the higher the stat
var spirit: int:
	get: return spirit
# Luck determines the Actor's likelihood to inflict and receive ailments and critical hits
var luck: int:
	get: return luck
# Maximum health that an Actor can have
var max_health: int:
	get: return max_health
# The Actor's current health; if this reaches 0, the Actor will be knocked out of the battle
var cur_health: int:
	get: return cur_health
# The Actor's maximum mp
var max_mp: int:
	get: return max_mp
# The Actor's current MP; if this is lower than a skill's MP cost, that skill cannot be used
var cur_mp: int:
	get: return cur_mp

signal death

func take_damage(val):
	cur_health -= val
	if cur_health <= 0:
		death.emit()

func heal(val):
	cur_health += val
	if cur_health > max_health:
		cur_health = max_health

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

