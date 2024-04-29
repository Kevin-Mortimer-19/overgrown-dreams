class_name BattleUIItemNode extends BattleUINode

var item: Item

func _init(i: Item, b_name: String = "", previous: BattleUINode = null, next: Dictionary = {}, t: Data.BattleTargets = Data.BattleTargets.NONE, sub = null):
	item = i
	super(b_name, previous, next, t, sub)
