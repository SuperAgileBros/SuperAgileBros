extends Actor


func _physics_process(_delta) -> void:
	var direction: = get_direction()
	velocity = calculate_velocity(velocity, direction, speed)
	velocity = move_and_slide(velocity, Vector2.UP)

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("character_right") - Input.get_action_strength("character_left"),
		-1.0 if Input.is_action_just_pressed("character_jump") and is_on_floor() else 1.0
	)

func calculate_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2
	) -> Vector2:
	var new_velocity = linear_velocity
	new_velocity.x = direction.x * speed.x
	new_velocity.y += gravity * get_physics_process_delta_time()
	if direction.y < 0:
		new_velocity.y = direction.y * speed.y
	return new_velocity
