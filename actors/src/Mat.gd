extends Player

func _ready():
	randomize()

func _action():
		var keys = items_common.keys()
		var key = keys[randi() % keys.size()]
		var item = load(items_common[key]).instance()
		item.position = position
		get_parent().add_child(item)


