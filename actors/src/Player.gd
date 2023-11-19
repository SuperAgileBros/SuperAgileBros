extends Actor
class_name Player

var face_right = true
var equipment = []
func _input(event):
	if event.is_action_pressed("character_action"):
		_action()
	if event.is_action_pressed("character_attack"):
		_attack()

func _attack():
	if equipment.size() > 0:
		pass
	else:
		print("no weapon equipped")
	pass

func _action():
	#implemented in character script
	pass

func _physics_process(_delta) -> void:
	var direction := get_direction()
	var sprite := get_child(0)
	
	if direction.x > 0:
		face_right = true
		sprite.scale.x = 1
	elif direction.x < 0:
		face_right = false
		sprite.scale.x = -1

	velocity = calculate_velocity(velocity, direction, speed)
	velocity = move_and_slide(velocity, Vector2.UP, false, 4, 0.785398, false)
	collision_process()
	
func collision_process():
	for i in range(get_slide_count()):
		var collision = get_slide_collision(i)
		if collision.collider is TileMap:
			pass
		elif collision.collider is Item:
			print(collision.collider)
			pickup_item(collision.collider)
		
		#zachowaniwe pędu przy kolizji z Rigidbody2D
		if (collision.collider != null) and (collision.collider is RigidBody2D):
			collision.collider.apply_central_impulse(-collision.normal * 100)
	pass

func pickup_item(item):
	if equipment.size() < 8:
		equipment.append(item)
		item.queue_free()
		

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
