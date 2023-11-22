extends Actor
class_name Player

const max_health = 100
onready var animation = $CollisionPolygon2D/Animation
var face_right = true
var health = max_health
var equipment = []
var action_press_time = 0
func _input(event):
	if event.is_action_pressed("character_action"):
		$ActionTimer.start()
	if event.is_action_released("character_action"):
		print($ActionTimer.get_time_left())
		$ActionTimer.stop()
	if event.is_action_pressed("character_attack"):
		_attack()

func _attack():
	if equipment.size() > 0:
		pass
	else:
		print("no weapon equipped")
	pass

func _action(action_press_time):
	#implemented in character script
	pass

func _physics_process(_delta) -> void:
	var direction := get_direction()
	var sprite := get_child(0)
	
	if direction.x > 0 and face_right == false:
		face_right = true
		scale.x = -1
	if direction.x < 0 and face_right == true:
		face_right = false
		scale.x = -1

	
	velocity = calculate_velocity(velocity, direction, speed)
	velocity = move_and_slide(velocity, Vector2.UP, false, 4, 0.785398, false)
	collision_process()
	
func collision_process():
	for i in range(get_slide_count()):
		var collision = get_slide_collision(i)
		if collision.collider is TileMap:
			pass
		elif collision.collider is Item:
			pickup_item(collision.collider)
		if collision.collider is KinematicBody2D:
			health = health - 1
			get_parent().set_health_bar() 
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
