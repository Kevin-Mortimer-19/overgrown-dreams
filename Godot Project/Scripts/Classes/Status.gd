class_name Status extends Node

var status_name: String
var status_type: Data.StatusTypes

var turns_remaining: int
var expired: bool

var positive: bool

func _init(d: StatusData, p: bool):
	status_name = d.status_name
	turns_remaining = 3
	expired = false
	positive = p

func _ready():
	pass

func turn_passed():
	turns_remaining -= 1
	if turns_remaining <= 0:
		expired = true

func is_expired():
	return expired
