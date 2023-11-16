extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var tomek = preload("res://actors/assets/tomek.png")
var mati = preload("res://actors/assets/mati.png")
var michal = preload("res://actors/assets/michal.png")
var kamil = preload("res://actors/assets/kamil.png")

onready var dummy_object = get_node("/root/Node2D/CollisionPolygon2D/CollisionPolygon2D/Sprite")
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta): 
	if  self.visible:
		if Input.is_action_just_pressed("character_right"):
			dummy_object.set_texture(michal)
		if Input.is_action_just_pressed("character_left"):
			dummy_object.set_texture(kamil)
		if Input.is_action_just_pressed("character_jump"):
			dummy_object.set_texture(mati)
		if Input.is_action_just_pressed("character_down"):
			dummy_object.set_texture(tomek)

