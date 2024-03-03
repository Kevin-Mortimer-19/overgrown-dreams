class_name EnemyActor extends Actor

var sprite_position: Vector2

func _initialize_enemy_actor(
	src_stats: Stats,
	src_sprite_pos: Vector2,
	) -> void:
	sprite_position = src_sprite_pos
	_initialize_actor(src_stats)
