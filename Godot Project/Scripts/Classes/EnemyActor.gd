class_name EnemyActor extends Actor

#var sprite_position: Vector2
var ui_sprite: Button


func _initialize_enemy_actor(
	src_stats: Stats,
#	src_sprite_pos: Vector2,
	src_ui_sprite: Button,
	) -> void:
#	sprite_position = src_sprite_pos
	ui_sprite = src_ui_sprite
	_initialize_actor(src_stats)
