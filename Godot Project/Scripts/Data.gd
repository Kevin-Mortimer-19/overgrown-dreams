extends Node

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
