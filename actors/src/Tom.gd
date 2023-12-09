extends Player

func _ready():
	randomize()

func _on_ActionTimer_timeout():
	var keys = equipment.keys()
	print(keys)
	if keys.size() > 0:
		var key = keys[randi() % keys.size()]
		print(key)
		var item  = equipment[key]
		print(item)
		if item != null:
			item.upgrade()
			emit_signal("update_hud")
	else:
		print("no items equipped")


func _attack():
	if equipment.size() > 0:
		pass
	else:
		animation.play("Kick")
		print("no weapon equipped")

