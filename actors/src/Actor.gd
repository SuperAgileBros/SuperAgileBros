extends KinematicBody2D
class_name Actor

export var speed: = Vector2(400.0,800.0)

export var gravity: = 3000.0

var velocity: = Vector2.ZERO

export var items_common = {
		"stick": "res://actors/items/Stick.tscn",
		"stone": "res://actors/items/Stone.tscn"
	}
func _ready():
	pause_mode = Node.PAUSE_MODE_STOP
