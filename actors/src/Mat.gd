extends Player

func _ready():
	randomize()

func _action():
		var keys = items_common.keys()
		var key = keys[randi() % keys.size()]
		var item = load(items_common[key]).instance()
		item.position = position
		get_tree().get_root().add_child(item)

func collision_process():
	for i in range(get_slide_count()):
		var collision = get_slide_collision(i)
		if collision.collider is TileMap:
			pass
		elif collision.collider.is_in_group("item"):
			print(collision.collider)
			collision.collider.queue_free()

