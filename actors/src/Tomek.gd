extends Player
#onready var animation = $CollisionPolygon2D/Animation

func _input(event):
	if event.is_action_pressed("character_action"):
		_action()

func _action():
	# Implemented in character script
	pass
	
		

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("character_right") - Input.get_action_strength("character_left"),
		-1.0 if Input.is_action_just_pressed("character_jump")  else 1.0
	)
