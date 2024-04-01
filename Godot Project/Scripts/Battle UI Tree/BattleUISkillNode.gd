class_name BattleUISkillNode extends BattleUINode

var skill: Skill 

func _init(s: Skill, b_name: String = "", previous: BattleUINode = null, next: Dictionary = {}, t: Data.BattleTargets = Data.BattleTargets.NONE, sub = null):
	skill = s
	super(b_name, previous, next, t, sub)
