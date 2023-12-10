extends Player


func _ready():
	randomize()

func _on_ActionTimer_timeout():
	var keys = equipment.keys()
	print(keys)
	if keys.size() > 0:
		var key = keys[randi() % keys.size()]
		print("to repair " + key)
		var item  = equipment[key]
		if item != null:
			item.item_durability = item.item_max_durability
			emit_signal("update_hud")
	else:
		print("no items equipped")
