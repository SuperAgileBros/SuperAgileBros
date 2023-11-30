extends Player

func _ready():
	randomize()

func _on_ActionTimer_timeout():
	print("timeout")
	var keys = items_common.keys()
	var key = keys[randi() % keys.size()]
	var item = load(items_common[key]).instance()
	item.position = get_node("Hand").global_position
	get_parent().add_child(item)
	if face_right:
		item.apply_central_impulse(Vector2(100, 0))
	else:
		item.apply_central_impulse(Vector2(-100, 0))
