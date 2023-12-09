extends Player


func _init():
	player_name = "MAT"

func _ready():
	randomize()

func _on_ActionTimer_timeout():
	print("timeout")
	var keys = items_material_common.keys()
	var key = keys[randi() % keys.size()]
	print(key)
	var item = load(items_material_common[key]).instance()
	spawn_item(item)


