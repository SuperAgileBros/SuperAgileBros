extends Enemy
class_name EliteSlime


var max_speed = 300
var jump_power = 300
var jump_timer = 0
var jump_interval_min = 1.0
var jump_interval_max = 2.0
var move_timer = 0
var move_interval_min = 1.0
var move_interval_max = 2.0
var damage = 20
var distance
var proximity_range = 300
var player
var node
var move_direction = 1  # Tu ustawiam chwilowo kierunek slime w trakcie jego wyszukiwnia gracza na scenie
onready var animation = $CollisionPolygon2D/AnimationSlime

func _ready():
	# Pobieram instancje gracza za pomocą nazwy, udało mi sie w skrypcie do zmiany gracza
	# przypisać wartość "Name" taką jaką miał poprzedni obiekt
	player = get_parent().get_node("Player")
	$Hitbox.damage = damage
	#connect("body_entered", self, "_on_RigidBody2D_body_entered")


func _process(delta):
	velocity.y += gravity * delta
	velocity.y = clamp(velocity.y, -max_speed, max_speed)
	
	if player and is_instance_valid(player):
		# Oblicz gdzie jest gracz
		distance = player.global_position.distance_to(self.global_position)
		if distance <= proximity_range:
			var direction_to_player = (player.global_position - global_position).normalized()

		# Ustawia prędkosć względem gracza
			velocity.x = direction_to_player.x * 150  # Tu możemy zwiększyć prędkosć slime
	else:
		# Jak funkcja zmiany postaci usuwa gracza na sam moment wyboru to slime musi sobie poczekać
		# chwilowo
		player = get_parent().get_node("Player") # Tu przypisuje od nowa gracza na tego który był wybrany
		move_timer -= delta
		if move_timer <= 0:
			move_timer = rand_range(move_interval_min, move_interval_max)
			move_direction *= -1  # Randomowo zmioenia kierunek
		velocity.x = move_direction * 100  # random prędkość
	#collision_process()	
	# timer random skoku
	jump_timer -= delta

	# tutaj jesli wartosc timerajest 0 lub nizej to kazde mu skakac
	if jump_timer <= 0:
		jump_timer = rand_range(jump_interval_min, jump_interval_max)
		jump()
	# Funkcja poruszania
	#velocity = move_and_slide(velocity, Vector2.UP)
	velocity = move_and_slide(velocity, Vector2.UP, false, 4, 0.785398, false)

	if health <= 0:
		animation.play("Death",false)

func jump():
	# sprawdza czy slime jest na ziemi
	if is_on_floor():
		# predkosc skoku
		velocity.y = -jump_power

func knockback(force, source_position):
	var direction = (global_position - source_position).normalized()
	velocity += direction * force

func die():
	queue_free()

