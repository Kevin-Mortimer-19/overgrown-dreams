extends TabContainer

@export var test: Equipment

@export var gear_list: Array[Equipment]

@onready var HeinrichGearMenu = $Heinrich
@onready var MarsGearMenu = $Mars
@onready var MedeaGearMenu = $Medea


func _ready():
	for e in gear_list:
		#print(e.equipment_name)
		match e.equip_type:
			Data.GearSlots.HEAD:
				HeinrichGearMenu.add_to_head_list(e)
				MarsGearMenu.add_to_head_list(e)
				MedeaGearMenu.add_to_head_list(e)
			Data.GearSlots.ARMS:
				HeinrichGearMenu.add_to_arm_list(e)
				MarsGearMenu.add_to_arm_list(e)
				MedeaGearMenu.add_to_arm_list(e)
			Data.GearSlots.CHEST:
				HeinrichGearMenu.add_to_chest_list(e)
				MarsGearMenu.add_to_chest_list(e)
				MedeaGearMenu.add_to_chest_list(e)
	HeinrichGearMenu.generate_menus()
	MarsGearMenu.generate_menus()
	MedeaGearMenu.generate_menus()


func equipment_swap(c: CharacterData, e: Equipment):
	match e.equip_type:
			Data.GearSlots.HEAD:
				c.helm = e
				equip_test(e.equipment_name, c.stats.actor_name)
			Data.GearSlots.ARMS:
				c.gloves = e
				equip_test(e.equipment_name, c.stats.actor_name)
			Data.GearSlots.CHEST:
				c.shirt = e
				equip_test(e.equipment_name, c.stats.actor_name)

func equip_test(en, cn):
	print("Equipped the " + en + " on " + cn + ".")
