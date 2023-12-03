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


func _ready():
	gravity_scale = 10
	pass
