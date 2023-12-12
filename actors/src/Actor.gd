extends KinematicBody2D
class_name Actor

var face_right = true

export var speed: = Vector2(400.0,800.0)

export var gravity: = 3000.0

var velocity: = Vector2.ZERO


export var items_material_common = {
		"wooden stick": "res://actors/items/WoodenStick.tscn",
		"stone": "res://actors/items/Stone.tscn",
		"rope": "res://actors/items/Rope.tscn",
		"woolsack": "res://actors/items/WoolSack.tscn",
		"bottle" : "res://actors/items/Bottle.tscn",
		"weed" : "res://actors/items/Weed.tscn",
		"flower": "res://actors/items/Flower.tscn",
		"copper wire": "res://actors/items/CopperWire.tscn",
		"iron pipe": "res://actors/items/IronPipe.tscn"
}

export var items_material_rare = {
		"wooden plank": "res://actors/items/WoodenPlank.tscn",
		"snowball": "res://actors/items/Snowball.tscn",
		"amber": "res://actors/items/Amber.tscn"
	}

export var items_weapon_common = {
		"wooden sword": "res://actors/items/WoodenSword.tscn",
		"bow": "res://actors/items/Bow.tscn",
		"hammer": "res://actors/items/Hammer.tscn",
		"iron hammer": "res://actors/items/IronHammer.tscn",
		"iron club": "res://actors/items/IronClub.tscn"
	}

func _ready():
	pause_mode = Node.PAUSE_MODE_STOP

func spawn_item(item):
	item.position = get_node("Hand").global_position
	get_parent().add_child(item)
	if face_right:
		item.apply_central_impulse(Vector2(100, 0))
	else:
		item.apply_central_impulse(Vector2(-100, 0))
