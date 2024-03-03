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
	
	
	Enemy1 = Actor.new()
	Enemy1._initialize_actor(Enemy1_stats)
	enemies.append(Enemy1)
	Enemy2 = Actor.new()
	Enemy2._initialize_actor(Enemy2_stats)
	enemies.append(Enemy2)
	
	# Create initial turn order
	
	turn_order = players + enemies
	turn_order.sort_custom(interaction.compare_speed)
	for i in turn_order.size():
		print(turn_order[i].stats.actor_name)
	
	AttackButton.pressed.connect(attack)

func attack():
	pass
	#msg.visible = !msg.visible

func _process(_delta):
	pass

