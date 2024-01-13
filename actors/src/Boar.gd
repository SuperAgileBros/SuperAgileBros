extends Enemy

# Add states for clarity
enum States { IDLE, WALKING, CHARGING }
var state = States.IDLE

var charge_speed = 300
var walk_speed = 100
var velocity = Vector2.ZERO
var charge_pause_time = 2.0
var walk_pause_time = 1.0
var damage = 2
var distance
var proximity_range = 300
var player
var node
var gravity = 400
var max_fall_speed = 500
var move_direction = Vector2(1, 0)
onready var sprite = $CollisionPolygon2D/Sprite
onready var animation = $CollisionPolygon2D/AnimationBoar

var charge_timer = 0.0
var walk_timer = 0.0

func _ready():
	player = get_parent().get_node("Player")
	animation.play("Walk")
	$Hitbox.damage = damage

func _process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		velocity.y = min(velocity.y, max_fall_speed)
	else:
		velocity.y = 0
	if velocity.x != 0:
		sprite.scale.x = sign(velocity.x) * -abs(sprite.scale.x)
	if player and is_instance_valid(player):
		distance = player.global_position.distance_to(global_position)
		if distance <= proximity_range and state != States.CHARGING:
			state = States.CHARGING
			charge_timer = charge_pause_time
		elif state == States.CHARGING:
			charge_timer -= delta
			if charge_timer <= 0:
				charge_at_player()
				state = States.IDLE
		else:
			handle_random_walking(delta)
	else:
		player = get_parent().get_node("Player")

	velocity = move_and_slide(velocity, Vector2.UP, false, 4, 0.785398, false)
	if health <= 0:
		animation.play("Death",false)

func charge_at_player():
	var direction_to_player = (player.global_position - global_position).normalized()
	velocity = direction_to_player * charge_speed
	if player.global_position.x < global_position.x:
		sprite.scale.x = abs(sprite.scale.x)  # Flip sprite to face left
	else:
		sprite.scale.x = -abs(sprite.scale.x)

func handle_random_walking(delta):
	walk_timer -= delta
	if walk_timer <= 0:
		if state == States.WALKING:
			state = States.IDLE
			walk_timer = walk_pause_time
		elif state == States.IDLE:
			state = States.WALKING
			walk_timer = rand_range(walk_pause_time, walk_pause_time * 2)
			move_direction = Vector2(randf() * 2 - 1, randf() * 2 - 1).normalized()
		# Removed the ternary operator and replaced it with an if-else block
		if state == States.WALKING:
			velocity = move_direction * walk_speed
		else:
			velocity = Vector2.ZERO

func jump():
	pass

func knockback(force, source_position):
	var direction = (global_position - source_position).normalized()
	velocity += direction * force

func die():
	queue_free()
