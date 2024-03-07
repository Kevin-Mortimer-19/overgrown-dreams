extends Node

## Define Actors for the battle prototype

@export var AttackButton: Button
@export var SkillButton: Button
@export var ItemButton: Button
@export var GuardButton: Button
@export var FleeButton: Button

var interaction = ActorInteractionEngine

var Mars: Actor
var Heinrich: Actor
var Medea: Actor

var Enemy1: Actor
var Enemy2: Actor

var Mars_stats = load("res://Characters/Stats/Mars.tres")
var Heinrich_stats = load("res://Characters/Stats/Heinrich.tres")
var Medea_stats = load("res://Characters/Stats/Medea.tres")

var Enemy1_stats = load("res://Characters/Stats/Enemy1.tres")
var Enemy2_stats = load("res://Characters/Stats/Enemy2.tres")

var players = []
var enemies = []
var turn_order

var current_actor: Actor

@onready var battle_menu = $BattleMainMenu
@onready var default_battle_button = $BattleMainMenu/AttackButton
@onready var enemy_menu = $EnemyContainer
@onready var default_enemy = $EnemyContainer/EnemyButton

@export var enemy_button_1: Button
@export var enemy_button_2: Button


signal enemy_selected(fun: Callable, player: Actor, enemy: EnemyActor)

func _ready():
	#enemy_menu.grab_focus()
	# This works, but there's definitely a cleaner way to do it
	Mars = Actor.new()
	Mars._initialize_actor(Mars_stats)
	players.append(Mars)
	Heinrich = Actor.new()
	Heinrich._initialize_actor(Heinrich_stats)
	players.append(Heinrich)
	Medea = Actor.new()
	Medea._initialize_actor(Medea_stats)
	players.append(Medea)
	
	
	Enemy1 = EnemyActor.new()
	Enemy1._initialize_enemy_actor(Enemy1_stats, enemy_button_1)
	enemies.append(Enemy1)
	Enemy2 = EnemyActor.new()
	Enemy2._initialize_enemy_actor(Enemy2_stats, enemy_button_2)
	enemies.append(Enemy2)
	
	# Create initial turn order
	
	turn_order = players + enemies
	turn_order.sort_custom(interaction.compare_speed)
	for i in turn_order.size():
		print(turn_order[i].stats.actor_name)
	
	current_actor = turn_order[0]
	print("The first to act is " + current_actor.stats.actor_name + "!")
	
	# Battle menu signal setup
	
	AttackButton.pressed.connect(select_enemy.bind(interaction.attack))
	
	start_new_turn()


func start_new_turn():
	if current_actor is EnemyActor:
		print("The " + current_actor.stats.actor_name + " is dancing crazy!")
		end_turn()
	else:
		open_menu()

func end_turn():
	turn_order.append(turn_order.pop_front())
	current_actor = turn_order[0]
	reset_enemy_select()
	start_new_turn()

func open_menu():
	battle_menu.visible = true
	default_battle_button.grab_focus.call_deferred()

func close_menu():
	battle_menu.visible = false
	battle_menu.release_focus()
	print("no menu")

func close_all_menus():
	battle_menu.visible = false
	for i in battle_menu.get_children():
		if i.has_focus():
			i.release_focus()
	for i in enemy_menu.get_children():
		if i.has_focus():
			i.release_focus()

func ui_grab_focus(element: Control):
	element.grab_focus()

func select_enemy(action: Callable):
	default_enemy.grab_focus()
	for i in enemies:
		i.ui_sprite.pressed.connect(turn_action.bind(action, current_actor, i))

func reset_enemy_select():
	for i in enemies:
		for j in i.ui_sprite.pressed.get_connections():
			i.ui_sprite.pressed.disconnect(j["callable"])

func turn_action(action: Callable, actor_1: Actor, actor_2: Actor):
	action.call(actor_1, actor_2)
	end_turn()
