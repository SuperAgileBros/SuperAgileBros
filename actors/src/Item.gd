extends RigidBody2D
class_name Item

export var item_name = ""
export var item_rarity = 0
export var item_types = ["resource", "weapon", "armor", "accessory", "consumable"]
export var item_type = 0
export var item_durability = 100

func _ready():
	gravity_scale = 10
	pass

