class_name ActorInteractionEngine extends Node

# This class mainly contains static functions that deal with two or more Actors interacting during battle

static func attack(attacker: Actor, defender: Actor) -> void:
	print(attacker.stats.actor_name + " attacks " + defender.stats.actor_name + "!")
	var damage = attacker.stats.attack - defender.stats.defense
	defender.take_damage(damage)

static func heal(doctor: Actor, patient: Actor) -> void:
	print(doctor.stats.actor_name + " heals " + patient.stats.actor_name + "!")
	var healing = doctor.stats.spirit
	patient.heal(healing)

static func compare_speed(actor1: Actor, actor2: Actor):
	if actor1.stats.speed > actor2.stats.speed:
		return true
	else:
		return false
