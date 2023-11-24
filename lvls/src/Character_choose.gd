extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var kamil_animation = $Kamil/AnimationPlayer
onready var michal_animation = $"Michał/AnimationPlayer"
onready var tomek_animation = $Tomek/AnimationPlayer
onready var mateusz_animation = $Mateusz/AnimationPlayer
onready var animations = [kamil_animation,michal_animation,tomek_animation,mateusz_animation]

var tomekCharacter : PackedScene = preload("res://actors/Tom.tscn")
var matCharacter : PackedScene = preload("res://actors/Mat.tscn")
var kamilCharacter : PackedScene = preload("res://actors/Kam.tscn")
var michalCharacter : PackedScene = preload("res://actors/Mic.tscn")
onready var currentKinematicBody = get_parent().get_parent().get_node("Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	print(currentKinematicBody)
	print($Player)
	print(get_parent().get_parent().get_node("Player"))
	
	pass # Replace with function body.

func _process(delta): 
	if  self.visible:	
		if Input.is_action_just_pressed("character_jump") and $"Mateusz/AnimationPlayer".is_playing()==false:
			_characterSwitch(matCharacter)
			stop_all_animations()
			$"Mateusz/AnimationPlayer".play("highlight")
		if Input.is_action_just_pressed("character_down") and $"Tomek/AnimationPlayer".is_playing()==false:
			_characterSwitch(tomekCharacter)
			stop_all_animations()
			$"Tomek/AnimationPlayer".play("highlight")
			
		if Input.is_action_just_pressed("character_right") and $"Michał/AnimationPlayer".is_playing()==false:
			_characterSwitch(michalCharacter)
			stop_all_animations()
			$"Michał/AnimationPlayer".play("highlight")
		
		if Input.is_action_just_pressed("character_left") and $"Kamil/AnimationPlayer".is_playing()==false:
			_characterSwitch(kamilCharacter)
			stop_all_animations()
			$"Kamil/AnimationPlayer".play("highlight")
		if Input.is_action_just_pressed("character_change_window"):
			stop_all_animations()
			
	#if not self.visible:
		
			
func _characterSwitch(choosenCharacter):
	$chooseSound.play()
	var instanceName = "Player"
	var previousKinematicBody = currentKinematicBody
	var currentindex = currentKinematicBody.get_index()
	currentKinematicBody.name = "TEMP"
	currentKinematicBody.queue_free()
	currentKinematicBody = choosenCharacter.instance()
	currentKinematicBody.position = previousKinematicBody.position
	currentKinematicBody.z_index = -1
	currentKinematicBody.name = instanceName
	get_parent().get_parent().add_child(currentKinematicBody,true)
	get_parent().get_parent().move_child(currentKinematicBody,currentindex)
	


func stop_all_animations():
	
	for animation in animations:
		animation.stop()

