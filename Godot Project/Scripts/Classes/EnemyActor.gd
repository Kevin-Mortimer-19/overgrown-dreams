extends Actor

var sprite_position: Vector2

func _initialize_enemy_actor(
	src_stats: Stats,
	src_sprite_pos: Vector2,
	) -> void:
	sprite_position = src_sprite_pos
	_initialize_actor(src_stats)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
