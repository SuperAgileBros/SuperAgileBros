extends Area2D
class_name Hitbox

export var damage = 0

func _on_Hitbox_body_entered(body):
	if owner.item_name == "bullet":
		queue_free()


func _on_Timer_timeout():
	#migotanie dla ciągłego zadawania obrażeń
	var shape = get_child(0)
	if shape.disabled == true:
		shape.disabled = false
	elif shape.disabled == false:
		shape.disabled = true
	
		
