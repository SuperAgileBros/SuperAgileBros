extends Item
export var updates = {
	1: {
		"item_rarity": 0,
		"item_max_durability": 100,
		"damage": 10,
		"work_cost": 1
	},
	2: {
		"item_rarity": 1,
		"item_max_durability": 200,
		"damage": 20,
		"work_cost": 2
	},
	3: {
		"item_rarity": 2,
		"item_max_durability": 300,
		"damage": 30,
		"work_cost": 3
	}
}
func _ready():
	$Sprite.frame = item_level-1

func upgrade():
	if item_level < 3:
		item_level += 1
		$Sprite.frame = item_level-1
		var new_stats = updates[item_level]
		item_rarity = new_stats["item_rarity"]
		item_max_durability = new_stats["item_max_durability"]
		damage = new_stats["damage"]
		work_cost = new_stats["work_cost"]
		
		
