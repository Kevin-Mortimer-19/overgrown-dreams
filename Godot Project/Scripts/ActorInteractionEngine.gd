class_name ActorInteractionEngine extends Node

# This class mainly contains static functions that deal with two or more Actors interacting during battle

static func attack(attacker: Actor, defenders: Array[Actor]) -> void:
	print(attacker.stats.actor_name + " attacks " + defenders[0].stats.actor_name + "!")
	var damage = attacker.stats.attack - defenders[0].stats.defense
	defenders[0].take_damage(damage)

static func heal(doctor: Actor, patients: Array[Actor]) -> void:
	print(doctor.stats.actor_name + " heals " + patients[0].stats.actor_name + "!")
	var healing = doctor.stats.spirit
	patients[0].heal(healing)

static func compare_speed(actor1: Actor, actor2: Actor):
	if actor1.stats.speed > actor2.stats.speed:
		return true
	else:
		return false

static func buff(coach: Actor, targets: Array[Actor]):
	pass

static func shield(defender: Actor, allies: Array[Actor]):
	pass

static func inflict_ailment(paralyzer: Actor, victims: Array[Actor]):
	pass

static func charge(big_guy: Actor, friends: Array[Actor]):
	pass
