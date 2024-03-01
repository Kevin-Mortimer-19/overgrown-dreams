extends Node

func attack(attacker: Actor, defender: Actor) -> void:
	var damage = attacker.attack - defender.defense
	defender.take_damage(damage)

func heal(doctor: Actor, patient: Actor) -> void:
	var healing = doctor.spirit
	patient.heal(healing)
