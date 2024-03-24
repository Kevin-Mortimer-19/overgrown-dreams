extends Node

# Global variables

enum BattleTargets {
	NONE = 0,
	SELF_ONLY = 1,
	ALLY = 2,
	ENEMY = 3,
	ALL_ALLIES = 4,
	ALL_ENEMIES = 5,
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
