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
	#Temporary print statement
	for i in turn_order.size():
		print(turn_order[i].stats.actor_name)
	
	current_actor = turn_order[0]
	print("The first to act is " + current_actor.stats.actor_name + "!")
	
	# Battle menu signal setup
	var attack_action = Action.new(interaction.attack, Data.BattleTargets.ENEMY)
	UITree.root.find_next("Attack").button.pressed.connect(select_target.bind("Attack", attack_action))
	UITree.root.find_next("Skill").button.pressed.connect(open_skill_menu)
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
		player_control = true
		create_skills_menu(current_actor)
		open_menu()

func end_turn():
	UITree.enemy_select = false
	turn_order.append(turn_order.pop_front())
	current_actor = turn_order[0]
	wipe_skills_menu()
	reset_enemy_select()
	start_new_turn()

func open_menu():
	battle_menu.visible = true
	UITree.return_to_root()
	UITree.focus_on_first()

func close_menu():
	battle_menu.visible = false
	battle_menu.release_focus()
	print("no menu")

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

func create_skills_menu(hero: HeroActor):
	var skill_node: BattleUINode = UITree.root.find_next("Skill")
	for i in hero.skills.SkillList:
		var option = BattleUISkillNode.new(i, i.skill_name, skill_node, {}, i.target, null)
		skill_node.append_next(option)
	for j in skill_node.find_all_next():
		skillmenu.add_child(j.button)
		var fun = find_skill_func(j.skill)
		j.button.pressed.connect(select_target.bind(j.button_name, Action.new(fun, j.skill.target)))

func wipe_skills_menu():
	var skill_node: BattleUINode = UITree.root.find_next("Skill")
	skill_node.remove_all_next()
	for i in skillmenu.get_children():
		i.queue_free()

func select_target(node_name: String, action: Action):
	UITree.target_selection(node_name)
	match action.target:
		Data.BattleTargets.ENEMY:
			#UITree.target_selection(node_name)
			default_enemy.grab_focus()
			for i in enemies:
				var a: Array[Actor] = [i]
				i.ui_button.pressed.connect(turn_action.bind(action.action, current_actor, a))
		Data.BattleTargets.ALLY:
			default_player.grab_focus()
			for i in players:
				var a: Array[Actor] = [i]
				i.ui_button.pressed.connect(turn_action.bind(action.action, current_actor, a))
		Data.BattleTargets.ALL_ALLIES:
			for p in players:
				single_action(action.action, current_actor, [p])
		Data.BattleTargets.ALL_ENEMIES:
			for e in enemies:
				single_action(action.action, current_actor, [e])
			end_turn()

func reset_enemy_select():
	for i in enemies:
		for j in i.ui_button.pressed.get_connections():
			i.ui_button.pressed.disconnect(j["callable"])
	for i in players:
		for j in i.ui_button.pressed.get_connections():
			i.ui_button.pressed.disconnect(j["callable"])

func turn_action(action: Callable, actor_1: Actor, other_actors: Array[Actor]):
	single_action(action, actor_1, other_actors)
	print("action taken")
	end_turn()

func single_action(action: Callable, actor_1: Actor,  other_actors: Array[Actor]):
	action.call(actor_1, other_actors)

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
