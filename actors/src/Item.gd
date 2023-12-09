extends RigidBody2D
class_name Item

export var item_name = ""
export var item_rarities = ["common","rare","unique","legendary"]
export var item_rarity = 0
export var item_types = ["resource", "weapon", "armor", "accessory", "consumable"]
export var item_type = 0
export var item_max_durability = 100
var item_durability = item_max_durability
export var work_cost = 0
export var item_level = 1
export var damage = 0

export var is_equipable = false
export var is_throwable = false

export var equip_rotation = 90

func _ready():
	gravity_scale = 10
	$Sprite/Hitbox.damage = damage

func _process(delta):
	if linear_velocity == Vector2(0,0):
		$Sprite/Hitbox/HitboxCollision.disabled = true
	else:
		$Sprite/Hitbox/HitboxCollision.disabled = false
