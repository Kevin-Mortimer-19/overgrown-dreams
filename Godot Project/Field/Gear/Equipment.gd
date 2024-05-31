class_name Equipment extends Resource

@export var equipment_name: String
@export var equip_type: Data.GearSlots
@export var modifier: int
#
#func _init(n: String, m: int, t: Data.GearSlots = Data.GearSlots.HEAD):
	#equipment_name = n
	#equip_type = t
	#modifier = m
