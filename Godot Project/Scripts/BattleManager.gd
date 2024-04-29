extends Node

var interaction = ActorInteractionEngine
var UITree: BattleUITree

## Define Actors for the battle prototype
var Mars: Actor
var Heinrich: Actor
var Medea: Actor

var Enemy1: Actor
var Enemy2: Actor

var Mars_stats = load("res://Characters/Stats/Mars.tres")
var Heinrich_stats = load("res://Characters/Stats/Heinrich.tres")
var Medea_stats = load("res://Characters/Stats/Medea.tres")

var Mars_skills = load("res://Characters/Skillsets/MarsSkillset.tres")
var Heinrich_skills = load("res://Characters/Skillsets/HeinrichSkillset.tres")
var Medea_skills = load("res://Characters/Skillsets/MedeaSkillset.tres")

var Enemy1_stats = load("res://Characters/Stats/Enemy1.tres")
var Enemy2_stats = load("res://Characters/Stats/Enemy2.tres")

var players = []
var enemies = []
var turn_order

var current_actor: Actor

var item_list: Array[Item]
# Temporary items to ensure the battle UI works properly
var salve = preload("res://Items/Health Potion.tres")
var numb_powder = preload("res://Items/Numbing Powder.tres")

# Temporary variable to store the currently selected item, will be replaced after rewriting target select func
var selected_item: Item


@onready var battle_menu = $BattleMainMenu
@onready var default_battle_button
@onready var enemy_menu = $EnemyContainer
@onready var default_enemy = $EnemyContainer/EnemyButton
var default_player

@export var Mars_button: Button
@export var Heinrich_button: Button
@export var Medea_button: Button

@export var enemy_button_1: Button
@export var enemy_button_2: Button

@onready var skillmenu = $SkillMenu
@onready var itemmenu = $ItemMenu

var player_control: bool

signal enemy_selected(fun: Callable, player: Actor, enemy: EnemyActor)

func _ready():
	#Initialize all actors and lists
	Mars = HeroActor.new(Mars_stats, Mars_skills, Mars_button)
	Heinrich = HeroActor.new(Heinrich_stats, Heinrich_skills, Heinrich_button)
	Medea = HeroActor.new(Medea_stats, Medea_skills, Medea_button)
	players = [Mars, Heinrich, Medea]
	default_player = Mars_button
	
	#This can be automated later for dynamic enemy encounters
	Enemy1 = EnemyActor.new(Enemy1_stats, enemy_button_1)
	Enemy2 = EnemyActor.new(Enemy2_stats, enemy_button_2)
	enemies = [Enemy1, Enemy2]
	
	# Initialize list of items
	item_list = []
	item_list.append(salve)
	item_list.append(numb_powder)
	
	
	# Battle Menu UI
	UITree = BattleUITree.new(BattleUINode.new("", null, {}, Data.BattleTargets.NONE, null))
	
	var BUI_attack = BattleUINode.new("Attack", UITree.root, {}, Data.BattleTargets.NONE, null)
	UITree.root.append_next(BUI_attack)
	var BUI_skill= BattleUINode.new("Skill", UITree.root, {}, Data.BattleTargets.NONE, skillmenu)
	UITree.root.append_next(BUI_skill)
	var BUI_item= BattleUINode.new("Item", UITree.root, {}, Data.BattleTargets.NONE, itemmenu)
	UITree.root.append_next(BUI_item)
	var BUI_defend= BattleUINode.new("Defend", UITree.root, {}, Data.BattleTargets.NONE, null)
	UITree.root.append_next(BUI_defend)
	var BUI_flee= BattleUINode.new("Flee", UITree.root, {}, Data.BattleTargets.NONE, null)
	UITree.root.append_next(BUI_flee)
	
	# Place buttons for the initial battle menu into the UI.
	for i in UITree.first_layer_buttons():
		battle_menu.add_child(i)
	
	# Create initial turn order
	turn_order = players + enemies
	turn_order.sort_custom(interaction.compare_speed)
	
	#print("Turn order:")
	#for i in turn_order.size():
		#print(turn_order[i].stats.actor_name)
	
	current_actor = turn_order[0]
	print("The first to act is " + current_actor.stats.actor_name + "!")
	
	# Battle menu signal setup
	UITree.root.find_next("Skill").button.pressed.connect(open_skill_menu)
	UITree.root.find_next("Item").button.pressed.connect(open_item_menu)
	default_battle_button = UITree.root.find_next("Attack").button
	
	start_new_turn()

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel") and UITree.current_node.previous_node != null and player_control:
		reset_enemy_select()
		UITree.cancel()

func start_new_turn():
	if current_actor is EnemyActor:
		player_control = false
		print("The " + current_actor.stats.actor_name + " is dancing crazy!")
		end_turn()
	elif current_actor is HeroActor:
		current_actor.start_of_turn()
		var attack_action = Action.new(current_actor, interaction.attack, Data.BattleTargets.ENEMY)
		UITree.root.find_next("Attack").button.pressed.connect(select_target.bind("Attack", attack_action))
		UITree.root.find_next("Defend").button.pressed.connect(actor_defend.bind(current_actor))
		player_control = true
		create_skills_menu(current_actor)
		create_items_menu()
		open_menu()

func end_turn():
	UITree.enemy_select = false
	current_actor.status_check()
	turn_order.append(turn_order.pop_front())
	current_actor = turn_order[0]
	selected_item = null
	wipe_player_menus()
	reset_enemy_select()
	start_new_turn()

func open_menu():
	battle_menu.visible = true
	UITree.return_to_root()
	UITree.focus_on_first()

func close_menu():
	battle_menu.visible = false
	battle_menu.release_focus()

# Might need to be deleted
func close_all_menus():
	battle_menu.visible = false
	for i in battle_menu.get_children():
		if i.has_focus():
			i.release_focus()
	for i in enemy_menu.get_children():
		if i.has_focus():
			i.release_focus()

func open_skill_menu():
	UITree.next_node("Skill")

func open_item_menu():
	UITree.next_node("Item")

func create_skills_menu(hero: HeroActor):
	var skill_node: BattleUINode = UITree.root.find_next("Skill")
	for i in hero.skills.SkillList:
		var option = BattleUISkillNode.new(i, i.skill_name, skill_node, {}, i.target, null)
		skill_node.append_next(option)
	for j in skill_node.find_all_next():
		skillmenu.add_child(j.button)
		var fun = find_skill_func(j.skill)
		var a = Action.new(current_actor, fun, j.skill.target, j.skill.power, j.skill.ailment_type, j.skill.buff_type)
		j.button.pressed.connect(select_target.bind(j.button_name, a))

func create_items_menu():
	if item_list != []:
		var item_node: BattleUINode = UITree.root.find_next("Item")
		for i in item_list:
			item_node.append_next(BattleUIItemNode.new(i, i.item_name + " x" + str(i.quantity), item_node, {}, i.skill.target, null))
			#var option = BattleUISkillNode.new()
		for j in item_node.find_all_next():
			itemmenu.add_child(j.button)
			var fun = find_skill_func(j.item.skill)
			var a = Action.new(current_actor, fun, j.item.skill.target, j.item.skill.power, j.item.skill.ailment_type, j.item.skill.buff_type)
			j.button.pressed.connect(select_target_with_item.bind(j.button_name, a, j.item))


func wipe_player_menus():
	var skill_node: BattleUINode = UITree.root.find_next("Skill")
	skill_node.remove_all_next()
	for i in skillmenu.get_children():
		i.queue_free()
	var item_node: BattleUINode = UITree.root.find_next("Item")
	item_node.remove_all_next()
	for i in itemmenu.get_children():
		i.queue_free()
	var attack_node: BattleUINode = UITree.root.find_next("Attack")
	for i in attack_node.button.pressed.get_connections():
		attack_node.button.pressed.disconnect(i["callable"])
	var defend_node: BattleUINode = UITree.root.find_next("Defend")
	for i in defend_node.button.pressed.get_connections():
		defend_node.button.pressed.disconnect(i["callable"])


func select_target(node_name: String, action: Action):
	UITree.target_selection(node_name)
	match action.target:
		Data.BattleTargets.ENEMY:
			default_enemy.grab_focus()
			for i in enemies:
				var a: Array[Actor] = [i]
				i.ui_button.pressed.connect(turn_action.bind(action, a))
		Data.BattleTargets.ALLY:
			default_player.grab_focus()
			for i in players:
				var a: Array[Actor] = [i]
				i.ui_button.pressed.connect(turn_action.bind(action, a))
		Data.BattleTargets.ALL_ALLIES:
			for p in players:
				single_action(action, [p])
		Data.BattleTargets.ALL_ENEMIES:
			for e in enemies:
				single_action(action, [e])
			end_turn()

func select_target_with_item(node_name: String, action: Action, i: Item):
	selected_item = i
	select_target(node_name, action)

func reset_enemy_select():
	for i in enemies:
		for j in i.ui_button.pressed.get_connections():
			i.ui_button.pressed.disconnect(j["callable"])
	for i in players:
		for j in i.ui_button.pressed.get_connections():
			i.ui_button.pressed.disconnect(j["callable"])

func turn_action(action: Action, targets: Array[Actor]):
	single_action(action, targets)
	if selected_item != null:
		selected_item.quantity -= 1
		if selected_item.quantity == 0:
			item_list.erase(selected_item)
			if item_list.is_empty():
				UITree.last_item_used(itemmenu)
	end_turn()

func single_action(action: Action, targets: Array[Actor]):
	action.action.call(action.initiator, targets, action.skillpower, action.buff, action.ailment)

func actor_defend(a: Actor):
	a.defend()
	end_turn()

func find_skill_func(s: Skill) -> Callable:
	match s.effect:
		Data.SkillEffects.ATTACK:
			return interaction.attack
		Data.SkillEffects.HEAL:
			return interaction.heal
		Data.SkillEffects.SHIELD:
			return interaction.shield
		Data.SkillEffects.AILMENT:
			return interaction.inflict_ailment
		Data.SkillEffects.CHARGE:
			return interaction.charge
		Data.SkillEffects.BUFF:
			return interaction.buff
		_:
			return interaction.attack
