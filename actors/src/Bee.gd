extends Enemy


var fly_speed = 150
var hover_amplitude = 50
var hover_frequency = 2
var move_timer = 0
var move_interval_min = 1.0
var move_interval_max = 2.0
var idle_move_speed = 50  # Reduced speed for idle movement
var damage = 2
var distance
var proximity_range = 300
var player
var node
var move_direction = Vector2(1, 0)
onready var animation = $CollisionPolygon2D/AnimationBee
onready var sprite = $CollisionPolygon2D/Sprite

func _ready():
	player = get_parent().get_node("Player")
	animation.play("Fly")
	$Hitbox.damage = damage

func _process(delta):
	if player and is_instance_valid(player):
		distance = player.global_position.distance_to(global_position)
		if distance <= proximity_range:
			# Move towards player like a bee
			var direction_to_player = (player.global_position - global_position).normalized()
			velocity.x = direction_to_player.x * fly_speed
			velocity.y = direction_to_player.y * fly_speed + sin(OS.get_ticks_msec() / 1000.0 * hover_frequency) * hover_amplitude
			if player.global_position.x < global_position.x:
				sprite.scale.x = abs(sprite.scale.x)  # Flip sprite to face left
			else:
				sprite.scale.x = -abs(sprite.scale.x)
		else:
			# Idle movement like a real bee
			move_timer -= delta
			if move_timer <= 0:
				move_timer = rand_range(move_interval_min, move_interval_max)
				move_direction = Vector2(randf() * 2 - 1, randf() * 2 - 1).normalized()  # Random new direction
			velocity = move_direction * idle_move_speed + Vector2(0, sin(OS.get_ticks_msec() / 1000.0 * hover_frequency) * hover_amplitude)
	else:
		player = get_parent().get_node("Player")
	
	velocity = move_and_slide(velocity, Vector2.UP, false, 4, 0.785398, false)

	if health <= 0:
		animation.play("Death",false)

func jump():
	pass

func knockback(force, source_position):
	var direction = (global_position - source_position).normalized()
	velocity += direction * force

func die():
	get_parent().kill_count["bee"] += 1
	print(get_parent().kill_count)
	if get_parent().kill_count["bee"] == 10:
		var boss = load("res://actors/EliteBee.tscn").instance()
		boss.set_position(global_position)
		get_parent().add_child(boss)
		get_parent().kill_count["bee"] = 0
		
	queue_free()
