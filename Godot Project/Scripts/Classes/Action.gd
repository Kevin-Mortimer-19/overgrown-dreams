class_name Action extends Node

var action: Callable

var target: Data.BattleTargets

func _init(a: Callable, t: Data.BattleTargets):
	action = a
	target = t
