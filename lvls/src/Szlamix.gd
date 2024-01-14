extends Hitbox


func _on_Area2D_body_entered(body):
	if body.name == "Player":
	  if body.climbing == false:
		  body.climbing = true

func _on_Szlamix_body_exited(body):
	if body.name == "Player":
	  if body.climbing == true:
		   body.climbing = false

