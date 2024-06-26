extends Node

# Ailment Resource Files

var Frail = preload("res://Battle/Ailments/Frail.tres")
var NullAilment = preload("res://Battle/Ailments/Null.tres")
var Rage = preload("res://Battle/Ailments/Rage.tres")
var Sap = preload("res://Battle/Ailments/Sap.tres")

# Buff Resource Files

var AttackUp = preload("res://Battle/Buffs/AttackUp.tres")
var DefenseUp = preload("res://Battle/Buffs/DefenseUp.tres")
var NullBuff = preload("res://Battle/Buffs/Null.tres")

# Global variables

enum BattleTargets {
	NONE = 0,
	SELF_ONLY = 1,
	ALLY = 2,
	OTHER_ALLY = 3,
	ENEMY = 4,
	ALL_ALLIES = 5,
	ALL_ENEMIES = 6,
}

enum SkillEffects {
	NONE = 0,
	ATTACK = 1,
	HEAL = 2,
	SHIELD = 3,
	AILMENT = 4,
	CHARGE = 5,
	BUFF = 6,
}

enum SkillPower {
	NONE = 0,
	LIGHT = 1,
	MEDIUM = 2,
	HEAVY = 3,
	SEVERE = 4,
	ALMIGHTY = 5,
}

enum StatusTypes {
	CHARGE = 0,
	BUFF = 1,
	AILMENT = 2,
	PERMANENT = 3,
}

enum BuffTypes {
	NONE = 0,
	ATTACK_UP = 1,
	DEFENSE_UP = 2,
}

enum AilmentTypes {
	NONE = 0,
	FRAIL = 1,
	RAGE = 2,
	SAP = 3,
}

enum GearSlots {
	HEAD = 0,
	CHEST = 1,
	ARMS = 2,
}

enum FieldStates {
	WALK = 0,
	DIALOGUE = 1,
	MENU = 2,
}

func find_ailment(type: AilmentTypes) -> AilmentData:
	match type:
		AilmentTypes.FRAIL:
			return Frail
		AilmentTypes.RAGE:
			return Rage
		AilmentTypes.SAP:
			return Sap
		_:
			return NullAilment

func find_buff(type: BuffTypes) -> BuffData:
	match type:
		BuffTypes.ATTACK_UP:
			return AttackUp
		BuffTypes.DEFENSE_UP:
			return DefenseUp
		_:
			return NullBuff
