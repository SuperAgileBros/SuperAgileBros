extends CanvasLayer


func _ready():
	#_backpack_change()
	pass
	
func _backpack_change():
	var player = get_parent().get_node("Player")
	for item in $Backpack.get_children():
		if item.get_child_count() > 0:
			for i in item.get_children():
				i.queue_free()
			
	var i = 0
	for item in player.backpack:
		var slot = $Backpack.get_node("slot_"+str(i))
		var sprite = Sprite.new()
		sprite = load(item["item_path"]).instance().get_node("Sprite").duplicate()
		sprite.position = Vector2(slot.rect_size.x/2,slot.rect_size.y/2)
		var durability = $Durability.duplicate()

		durability.max_value = item["item_max_durability"]
		durability.value = item["item_durability"]
		sprite.add_child(durability)
		durability.show()
		slot.add_child(sprite)
		i += 1
	for j in range(get_parent().throphy.size()):
		if get_parent().throphy[j]:
			$Equipment/Throphy.get_child(j).modulate = Color(1,1,1,1)
	add_equipment(player.equipment["weapon"],$Equipment/Weapon)
	add_equipment(player.equipment["armor"],$Equipment/Armor)
	#add_equipment(player.equipment["accessory"],$Equipment/Accessory)
	#add_equipment(player.equipment["consumable"],$Equipment/Consumable)
	
func add_equipment(var equipment,var equipment_slot):
	print(equipment)
	for item in equipment_slot.get_children():
		item.queue_free()
	if equipment != null:
		var sprite = load(equipment["item_path"]).instance().get_node("Sprite").duplicate()
		if equipment["item_level"] > 1:
			sprite.frame = equipment["item_level"]-1
		sprite.position = Vector2(equipment_slot.rect_size.x/2,equipment_slot.rect_size.y/2)
		var durability = $Durability.duplicate()
		sprite.add_child(durability)
		durability.show()
		durability.max_value = equipment["item_max_durability"]
		durability.value = equipment["item_durability"]
		equipment_slot.add_child(sprite)
func _portrait():
	var player = get_parent().get_node("Player").get_node("CollisionPolygon2D").get_node("Sprite")
	var portrait = $PortraitFrame/Portrait
	portrait.texture.atlas = player.texture


func _on_update_hud():
	_backpack_change()
	_portrait()
