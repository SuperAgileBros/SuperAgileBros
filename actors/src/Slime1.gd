extends KinematicBody2D

var velocity = Vector2.ZERO
var gravity = 800
var jump_power = 350
var jump_timer = 0
var jump_interval_min = 1.0
var jump_interval_max = 2.0
var move_timer = 0
var move_interval_min = 1.0
var move_interval_max = 2.0

var player
var node
var move_direction = 1  # Tu ustawiam chwilowo kierunek slime w trakcie jego wyszukiwnia gracza na scenie


func _ready():
	# Pobieram instancje gracza za pomocą indexu, poniewaz ustawiany jest na 0
	# Inaczej mozna to zrobic najpierw za pomcoa nazwy, a index przypisac do
	# jakiejs zmiennej
	node = get_node("/root/Node2D")
	player = node.get_child(0)

	

func _process(delta):
	velocity.y += gravity * delta

	if player and is_instance_valid(player):
		# Oblicz gdzie jest gracz
		var direction_to_player = (player.global_position - global_position).normalized()

		# Ustawia prędkosć względem gracza
		velocity.x = direction_to_player.x * 100  # Tu możemy zwiększyć prędkosć slime
	else:
		# Jak funkcja zmiany postaci usuwa gracza na sam moment wyboru to slime musi sobie poczekać
		# chwilowo
		player = node.get_child(0) # Tu przypisuje od nowa gracza na tego który był wybrany
		move_timer -= delta
		if move_timer <= 0:
			move_timer = rand_range(move_interval_min, move_interval_max)
			move_direction *= -1  # Randomowo zmioenia kierunek
		velocity.x = move_direction * 100  # random prędkość
	# Funkcja poruszania
	velocity = move_and_slide(velocity, Vector2.UP)

	# timer random skoku
	jump_timer -= delta

	# tutaj jesli wartosc timerajest 0 lub nizej to kazde mu skakac
	if jump_timer <= 0:
		jump_timer = rand_range(jump_interval_min, jump_interval_max)
		jump()

func jump():
	# sprawdza czy slime jest na ziemi
	if is_on_floor():
		# predkosc skoku
		velocity.y = -jump_power
