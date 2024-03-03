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

signal enemy_selected(enemy: EnemyActor)

func _ready():
	# Attributes are, in order: attack, defense, speed, spirit, luck, max/current hp, max/current mp
	
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
	Enemy1._initialize_enemy_actor(Enemy1_stats, Vector2(1,1))
	enemies.append(Enemy1)
	Enemy2 = EnemyActor.new()
	Enemy2._initialize_enemy_actor(Enemy2_stats, Vector2(1,1))
	enemies.append(Enemy2)
	
	# Create initial turn order
	
	turn_order = players + enemies
	turn_order.sort_custom(interaction.compare_speed)
	for i in turn_order.size():
		print(turn_order[i].stats.actor_name)
	
	current_actor = turn_order[0]
	print("The first to act is " + current_actor.stats.actor_name + "!")
	
	AttackButton.pressed.connect(select_enemy)
	
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
	start_new_turn()

func open_menu():
	battle_menu.visible = true
	battle_menu.grab_focus()

func close_menu():
	battle_menu.visible = false
	battle_menu.release_focus()



func select_enemy():
	print(current_actor.stats.actor_name + " attacks!")
	end_turn()

func interact_with_enemy(fun: Callable, player: Actor):
	pass

func attack():
	pass
