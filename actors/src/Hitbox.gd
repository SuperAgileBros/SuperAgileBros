extends Area2D
class_name Hitbox

export var damage = 0

func _on_Hitbox_body_entered(body):
	if owner is Item and owner.item_name == "bullet":
		yield(get_tree().create_timer(1.0), "timeout")
		queue_free()


func _on_Timer_timeout():
	#migotanie dla ciągłego zadawania obrażeń
	var shapes = get_children()
	for shape in shapes:
		if shape is CollisionShape2D:
			if shape.disabled == true:
				shape.disabled = false
			elif shape.disabled == false:
				shape.disabled = true
	
		
