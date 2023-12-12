extends Area2D
class_name Hitbox

export var damage = 0

func _on_Hitbox_body_entered(body):
	if owner.item_name == "bullet":
		queue_free()
