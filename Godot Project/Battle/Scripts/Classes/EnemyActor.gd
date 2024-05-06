class_name EnemyActor extends Actor

var ui_sprite: Button

func _init(
	src_stats: Stats,
	src_ui_button: Button,
	) -> void:
	#ui_sprite = src_ui_sprite
	super(src_stats, src_ui_button)
