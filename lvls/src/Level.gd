extends Node2D
class_name Level

var hud = preload("res://lvls/HUD.tscn")

export var players = {
	"MAT":preload("res://actors/Mat.tscn"),
	"KAM":preload("res://actors/Kam.tscn"),
	"TOM":preload("res://actors/Tom.tscn"),
	"MIC":preload("res://actors/Mic.tscn")
}
export var current_player: String = "MAT"

var characterChooseVisible: bool = false

func _init():
	hud = hud.instance()
	hud.name = "HUD"
	add_child(hud)
	_add_player()


func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	set_health_bar() 
	if $PlayerSpawn != null:
		$Player.set_position($PlayerSpawn.position)

func _add_player():
	var player = players[current_player].instance()
	player.name = "Player"
	add_child(player)


func set_health_bar() -> void:
	$HUD/HealthBar.value = $Player.health

func _process(_delta):
	if Input.is_action_just_pressed("menu"):
		if get_tree().paused:
			$HUD/Menu_pause.hide()
			get_tree().paused = false
		else:
			get_tree().paused = true
			$HUD/Menu_pause.show()
	if Input.is_action_just_pressed("character_change_window") and not characterChooseVisible:
		if not $HUD/Character_choose.visible:
			get_tree().paused = true
			$HUD/Character_choose.show()
			characterChooseVisible = true

	elif Input.is_action_just_released("character_change_window") and characterChooseVisible:
			get_tree().paused = false
			$HUD/Character_choose.hide()
			characterChooseVisible = false
		
##	if Input.is_action_just_pressed("character_change"):   // Michał ne wywalaj jeszcze tego proszę :D
	#	if get_tree().paused: 
	#		$Character_choose.hide()
	#		get_tree().paused = false
	#	else:
	#		get_tree().paused = true
	#		$Character_choose.show()

