extends CanvasLayer


func _ready():
	_backpack_change()
	
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
		sprite.texture = item.get_node("Sprite").texture
		sprite.position = Vector2(slot.rect_size.x/2,slot.rect_size.y/2)
		slot.add_child(sprite)
		i += 1

	add_equipment(player.equipment["weapon"],$Equipment/Weapon)
	add_equipment(player.equipment["armor"],$Equipment/Armor)
	add_equipment(player.equipment["accessory"],$Equipment/Accessory)
	add_equipment(player.equipment["consumable"],$Equipment/Consumable)
	
func add_equipment(var equipment,var equipment_slot):
	if equipment != null:
		if equipment_slot.get_child_count() != 0:
			equipment.get_child(0).texture = equipment.get_node("Sprite").texture
		else:
			var sprite = Sprite.new()
			sprite.texture = equipment.get_node("Sprite").texture
			sprite.position = Vector2(equipment_slot.rect_size.x/2,equipment_slot.rect_size.y/2)
			equipment_slot.add_child(sprite)
	else:
		if equipment_slot.get_child_count() != 0:
			equipment_slot.get_child(0).queue_free()
func _portrait():
	var player = get_parent().get_node("Player").get_node("CollisionPolygon2D").get_node("Sprite")
	var portrait = $PortraitFrame/Portrait
	portrait.texture.atlas = player.texture
	print("portrait")
	print(portrait.texture.to_string())

func _on_update_hud():
	_backpack_change()
	_portrait()
