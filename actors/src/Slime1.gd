extends KinematicBody2D

var velocity = Vector2.ZERO
var gravity = 800
var jump_power = 350
var jump_timer = 0
var jump_interval_min = 1.0
var jump_interval_max = 3.0
var move_timer = 0
var move_interval_min = 1.0
var move_interval_max = 2.0
var move_direction = 1  # 1 for right, -1 for left

func _process(delta):
	velocity.y += gravity * delta

	move_timer -= delta
	if move_timer <= 0:
		move_timer = rand_range(move_interval_min, move_interval_max)
		move_direction *= -1  # Change direction randomly
	velocity.x = move_direction * 100  # Adjust the horizontal speed as needed

	# Move the enemy
	velocity = move_and_slide(velocity, Vector2.UP)

	# Update the jump timer
	jump_timer -= delta

	# Check if it's time to jump
	if jump_timer <= 0:
		jump_timer = rand_range(jump_interval_min, jump_interval_max)
		jump()

func jump():
	# Check if the enemy is on the ground (collision with the ground)
	if is_on_floor():
		# Jump by setting the y-velocity
		velocity.y = -jump_power
