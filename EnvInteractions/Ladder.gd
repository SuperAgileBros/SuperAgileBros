extends Area2D



func _on_Area2D_body_entered(body):
	if body.name == "Player":
	  if body.climbing == false:
		  body.climbing = true


func _on_Ladder_body_exited(body):
	if body.name == "Player":
	  if body.climbing == true:
		   body.climbing = false

