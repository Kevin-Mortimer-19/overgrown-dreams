class_name ActorInteractionEngine extends Node

# This class mainly contains static functions that deal with two or more Actors interacting during battle

static func compare_speed(actor1: Actor, actor2: Actor):
	if actor1.stats.speed > actor2.stats.speed:
		return true
	else:
		return false

static func attack(attacker: Actor, defenders: Array[Actor], power: Data.SkillPower, _b_type = Data.BuffTypes.NONE, _a_type = Data.AilmentTypes.NONE) -> void:
	print(attacker.stats.actor_name + " attacks " + defenders[0].stats.actor_name + "!")
	var damage = attacker.stats.attack - defenders[0].stats.defense
	defenders[0].take_damage(damage)

static func heal(doctor: Actor, patients: Array[Actor], power: Data.SkillPower, _b_type = Data.BuffTypes.NONE, _a_type = Data.AilmentTypes.NONE) -> void:
	print(doctor.stats.actor_name + " heals " + patients[0].stats.actor_name + "!")
	var healing = doctor.stats.spirit
	patients[0].heal(healing)

static func buff(helper: Actor, targets: Array[Actor], power: Data.SkillPower, b_type = Data.BuffTypes.NONE, _a_type = Data.AilmentTypes.NONE):
	print(helper.stats.actor_name + " used a(n) " + Data.BuffTypes.keys()[b_type] + " skill on target " + targets[0].stats.actor_name + "!")

static func shield(defender: Actor, allies: Array[Actor], power: Data.SkillPower, _b_type = Data.BuffTypes.NONE, _a_type = Data.AilmentTypes.NONE):
	pass

static func inflict_ailment(paralyzer: Actor, victims: Array[Actor], power: Data.SkillPower, _b_type = Data.BuffTypes.NONE, a_type = Data.AilmentTypes.NONE):
	for e in victims:
		if paralyzer.stats.luck > e.stats.luck:
			e.add_status(Data.find_ailment(a_type))
			print(paralyzer.stats.actor_name + " used a(n) " + Data.AilmentTypes.keys()[a_type] + " skill on target " + victims[0].stats.actor_name + "!")

static func charge(big_guy: Actor, friends: Array[Actor], power: Data.SkillPower, _b_type = Data.BuffTypes.NONE, _a_type = Data.AilmentTypes.NONE):
	pass
