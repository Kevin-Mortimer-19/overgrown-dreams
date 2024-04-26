class_name StatusManager extends Node

var BuffManager: Array[BuffData] = []
var AilmentManager: Array[AilmentData] = []

func add_status(data: StatusData):
	var s = null
	if data is AilmentData:
		add_ailment(data)
	elif data is BuffData:
		add_buff(data)

func add_buff(b: BuffData):
	var s = Status.new(b, true)
	apply_status(s, BuffManager)

func add_ailment(a: AilmentData):
	var s = Status.new(a, false)
	apply_status(s, AilmentManager)

func apply_status(s: Status, a: Array):
	## Add clause to check if status is already in effect
	if a.size() >= 3:
		a.pop_front()
	a.append(s)

## Calls turn_passed() on each buff and ailment to reduce their remaining active turns by one
func end_of_turn():
	for a in AilmentManager:
		a.turn_passed()
	for b in BuffManager:
		b.turn_passed()
