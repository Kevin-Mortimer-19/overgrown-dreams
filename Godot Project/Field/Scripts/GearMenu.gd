extends TabContainer

@export var test: Equipment

var gear_list: Array[UniqueItem]

@onready var HeinrichGearMenu = $Heinrich
@onready var MarsGearMenu = $Mars
@onready var MedeaGearMenu = $Medea

func _ready():
	#for e in gear_list:
		##print(e.equipment_name)
		#match e.equip_type:
			#Data.GearSlots.HEAD:
				#HeinrichGearMenu.add_to_head_list(e)
				#MarsGearMenu.add_to_head_list(e)
				#MedeaGearMenu.add_to_head_list(e)
			#Data.GearSlots.ARMS:
				#HeinrichGearMenu.add_to_arm_list(e)
				#MarsGearMenu.add_to_arm_list(e)
				#MedeaGearMenu.add_to_arm_list(e)
			#Data.GearSlots.CHEST:
				#HeinrichGearMenu.add_to_chest_list(e)
				#MarsGearMenu.add_to_chest_list(e)
				#MedeaGearMenu.add_to_chest_list(e)
	#HeinrichGearMenu.generate_menus()
	#MarsGearMenu.generate_menus()
	#MedeaGearMenu.generate_menus()
	tab_changed.connect(open_menu)
	open_menu(current_tab)

func open_menu(tab: int):
	var current_tab = find_current_tab(tab)
	current_tab.wipe_menus()
	for e in gear_list:
		#print(e.equipment_name)
		match e.item.equip_type:
			Data.GearSlots.HEAD:
				current_tab.add_to_head_list(e.item)
			Data.GearSlots.ARMS:
				current_tab.add_to_arm_list(e.item)
			Data.GearSlots.CHEST:
				current_tab.add_to_chest_list(e.item)
	current_tab.generate_menus()

func find_current_tab(tab: int):
	match tab:
		0: 
			return HeinrichGearMenu
		1: 
			return MarsGearMenu
		2: 
			return MedeaGearMenu
		_:
			return MarsGearMenu

func equipment_swap(c: CharacterData, e: Equipment):
	match e.equip_type:
			Data.GearSlots.HEAD:
				if c.helm.equipment_name != "None":
					add_gear(c.helm)
				c.helm = e
				equip_test(c.helm.equipment_name, c.stats.actor_name)
				remove_gear(e)
			Data.GearSlots.ARMS:
				if c.gloves.equipment_name != "None":
					add_gear(c.gloves)
				c.gloves = e
				equip_test(c.gloves.equipment_name, c.stats.actor_name)
				remove_gear(e)
			Data.GearSlots.CHEST:
				if c.shirt.equipment_name != "None":
					add_gear(c.shirt)
				c.shirt = e
				equip_test(c.shirt.equipment_name, c.stats.actor_name)
				remove_gear(e)

func equip_test(en, cn):
	print("Equipped the " + en + " on " + cn + ".")

func add_gear(e: Equipment):
	var idx = search_gear_list(e)
	if idx == -1:
		gear_list.append(UniqueItem.new(e, 1))
	else:
		gear_list[idx].add_item(1)

func remove_gear(e: Equipment):
	var idx = search_gear_list(e)
	if idx == -1:
		print("?????")
	else:
		gear_list[idx].remove_item(1)
		if gear_list[idx].empty():
			gear_list.remove_at(idx)

# Search through the list of available equipment for a specific item. If it is found, return the index in the array;
# otherwise return -1
func search_gear_list(e: Equipment) -> int:
	var i = 0
	for j in gear_list:
		if gear_list[i].has(e):
			return i
		i += 1
	return -1
