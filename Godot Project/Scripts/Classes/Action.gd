class_name Action extends Node

var initiator: Actor

var action: Callable

var target: Data.BattleTargets

var skillpower: Data.SkillPower

var ailment: Data.AilmentTypes

var buff: Data.BuffTypes

func _init(i: Actor, a: Callable, t: Data.BattleTargets,
			s: Data.SkillPower = Data.SkillPower.NONE,
			ail: Data.AilmentTypes = Data.AilmentTypes.NONE, 
			b: Data.BuffTypes = Data.BuffTypes.NONE):
	initiator = i
	action = a
	target = t
	skillpower = s
	ailment = ail
	buff = b
