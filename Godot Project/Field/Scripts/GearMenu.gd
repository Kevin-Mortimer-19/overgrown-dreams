extends TabContainer

@export var test: Equipment

@export var gear_list: Array[Equipment]

@onready var HeinrichGearMenu = $Heinrich


func _ready():
	for e in gear_list:
		#print(e.equipment_name)
		match e.equip_type:
			Data.GearSlots.HEAD:
				HeinrichGearMenu.add_to_head_list(e)
			Data.GearSlots.ARMS:
				HeinrichGearMenu.add_to_arm_list(e)
			Data.GearSlots.CHEST:
				HeinrichGearMenu.add_to_chest_list(e)
	HeinrichGearMenu.generate_menus()
	
