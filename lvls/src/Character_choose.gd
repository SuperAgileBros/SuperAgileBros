extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
var tomekCharacter : PackedScene = preload("res://actors/Tomek.tscn")
var matCharacter : PackedScene = preload("res://actors/Mat.tscn")
var kamilCharacter : PackedScene = preload("res://actors/Kamil.tscn")
var michalCharacter : PackedScene = preload("res://actors/Michal.tscn")
onready var currentKinematicBody = get_node("/root/Node2D/CollisionPolygon2D")

func _process(delta): 
	if  self.visible:	
		if Input.is_action_just_pressed("character_jump"):
			_characterSwitch(matCharacter)
			
		if Input.is_action_just_pressed("character_down"):
			_characterSwitch(tomekCharacter)
		
		if Input.is_action_just_pressed("character_right"):
			_characterSwitch(michalCharacter)
		
		if Input.is_action_just_pressed("character_left"):
			_characterSwitch(kamilCharacter)
			
func _characterSwitch(choosenCharacter):
	var previousKinematicBody = currentKinematicBody
	var currentindex = currentKinematicBody.get_index()
	currentKinematicBody.queue_free()
	currentKinematicBody = choosenCharacter.instance()
	currentKinematicBody.position = previousKinematicBody.position
	currentKinematicBody.z_index = -1
	get_parent().add_child(currentKinematicBody,currentindex)
