extends CanvasLayer


func _ready():
	_equipment_change()
	
func _equipment_change():
	for item in $Equipment.get_children():
		if item.get_child_count() > 0:
			item.get_child(0).queue_free()
	var i = 0
	for item in get_parent().get_node("Player").equipment:
		var sprite = Sprite.new()
		sprite.texture = item.get_node("Sprite").texture
		var slot = $Equipment.get_node("slot_"+str(i))
		sprite.position = Vector2(slot.rect_size.x/2,slot.rect_size.y/2)
		slot.add_child(sprite)
		i += 1
			

func _on_update_hud():
	print("hud_update")
	_equipment_change()
