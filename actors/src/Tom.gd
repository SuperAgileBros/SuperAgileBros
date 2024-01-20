extends Player

func _ready():
	randomize()

func _process(delta):
	if $ActionTimer.is_stopped():
		$Charge.stop()
	else:
		if $Charge.is_playing():
			pass
		else:
			$Charge.play()

func _on_ActionTimer_timeout():
	var keys = equipment.keys()
	print(keys)
	if keys.size() > 0:
		var key = keys[randi() % keys.size()]
		print(key)
		var item  = equipment[key]
		print(item)
		if item != null and item["item_level"] < 3:
			$Ablility.play()
			var upgraged_item = load(items[item["item_name"]]).instance()
			upgraged_item.upgrade()
			item["item_level"] = item["item_level"]+1
			item["item_name"] = upgraged_item.item_name
			item["item_max_durability"] = upgraged_item.item_max_durability
			item["damage"] = upgraged_item.damage
			item["work_cost"] = upgraged_item.work_cost
			print("upgraded item to: " + str(item))
			equipment[key] = item
			emit_signal("update_hud")
		else:
			$Fail.play()
	else:
		print("no items equipped")
