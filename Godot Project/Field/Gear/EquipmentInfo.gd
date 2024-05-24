extends Object


# Testing inner classes, but the class needs to be accessible to other scripts, so this is unused for now
class Gear:
	var name_string: String
	var slot: Data.GearSlots
	
	func _init(n, t):
		name_string = n
		slot = t



var leather_chest = Equipment.new("Leather Chestpiece", Data.GearSlots.CHEST)
var iron_chest = Equipment.new("Iron Chestpiece", Data.GearSlots.CHEST)

var leather_arms = Equipment.new("Leather Chestpiece", Data.GearSlots.CHEST)
var iron_arms = Equipment.new("Iron Chestpiece", Data.GearSlots.CHEST)

var leather_pants = Equipment.new("Leather Chestpiece", Data.GearSlots.CHEST)
var iron_pants = Equipment.new("Iron Chestpiece", Data.GearSlots.CHEST)
