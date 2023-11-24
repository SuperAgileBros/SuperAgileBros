extends Node2D
class_name Level

var menu_pause = preload("res://menus/Menu_pause.tscn")
export var players = {
	"MAT":preload("res://actors/Mat.tscn"),
	"KAM":preload("res://actors/Kam.tscn"),
	"TOM":preload("res://actors/Tom.tscn"),
	"MIC":preload("res://actors/Mic.tscn")
}

export var current_player: String = "MAT"

var characterChooseVisible: bool = false

func _init():
	_add_player()

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	set_health_bar() 

func _add_player():
	var player = players[current_player].instance()
		
	if $Player_spawn != null:
		player.position = $Player_spawn.position
	player.name = "Player"
	add_child(player)


func set_health_bar() -> void:
	$CanvasLayer/HealthBar.value = $Player.health

func _process(_delta):
	if Input.is_action_just_pressed("menu"):
		if get_tree().paused:
			$Menu_pause.hide()
			get_tree().paused = false
		else:
			get_tree().paused = true
			$Menu_pause.show()
	if Input.is_action_just_pressed("character_change_window") and not characterChooseVisible:
		if not $CanvasLayer/Character_choose.visible:
			get_tree().paused = true
			$CanvasLayer/Character_choose.show()
			characterChooseVisible = true

	elif Input.is_action_just_released("character_change_window") and characterChooseVisible:
			get_tree().paused = false
			$CanvasLayer/Character_choose.hide()
			characterChooseVisible = false
	if $Player.health <= 0:
		play_death_animation()
		
##	if Input.is_action_just_pressed("character_change"):   // Michał ne wywalaj jeszcze tego proszę :D
	#	if get_tree().paused: 
	#		$Character_choose.hide()
	#		get_tree().paused = false
	#	else:
	#		get_tree().paused = true
	#		$Character_choose.show()

func play_death_animation():
	 $Player.animation.play("Death", false)
