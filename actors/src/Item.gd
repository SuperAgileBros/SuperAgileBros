extends RigidBody2D
class_name Item

export var item_name = ""
export var item_rarities = ["common","rare","unique","legendary"]
export var item_rarity = 0
export var item_types = ["resource", "weapon", "armor", "accessory", "consumable"]
export var item_type = 0
export var item_max_durability = 100
export var item_durability = 1
export var work_cost = 0
export var item_level = 1
export var damage = 0

export var is_equipable = false
export var is_throwable = false

export var equip_rotation = 90

export var pickup_sound = "res://sound_effects/pickup2.wav"
var audio_player = AudioStreamPlayer.new()

func _init():
	audio_player.name = "PickupSound"
	audio_player.stream = load(pickup_sound)
	
func _ready():
	z_index = 1
	gravity_scale = 10
	$Sprite/Hitbox.damage = damage
	name = item_name
	item_durability = item_max_durability
	add_child(audio_player)

func _process(delta):
	if linear_velocity < Vector2(1,1):
		$Sprite/Hitbox/HitboxCollision.disabled = true
	else:
		$Sprite/Hitbox/HitboxCollision.disabled = false


func work():
	item_durability -= work_cost
	if item_durability <= 0:
		queue_free()

func pickup():
	audio_player.play()
