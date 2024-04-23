class_name Status extends Resource

var max_duration
var remaining_duration

func _init(m_duration: int = 3):
	max_duration = m_duration
	remaining_duration = max_duration

func duration_increment():
	remaining_duration -= 1

func still_active() -> bool:
	if remaining_duration > 0:
		return true
	else:
		return false
