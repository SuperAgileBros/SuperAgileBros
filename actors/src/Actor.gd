extends KinematicBody2D
class_name Actor

export var speed: = Vector2(300.0,1000.0)
export var gravity: = 5000.0

var velocity: = Vector2.ZERO

export var items_common = {
		"stick": "res://actors/items/Stick.tscn",
		"stone": "res://actors/items/Stone.tscn"
	}
