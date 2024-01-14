extends Node2D
class_name Level

var hud = preload("res://lvls/HUD.tscn")

export var save_data = {}

export var players = {
	"MAT":preload("res://actors/Mat.tscn"),
	"KAM":preload("res://actors/Kam.tscn"),
	"TOM":preload("res://actors/Tom.tscn"),
	"MIC":preload("res://actors/Mic.tscn")
}
export var current_player: String = "MAT"

var characterChooseVisible: bool = false
func get_save_data():
	var new_save_data := {}
	var actors := get_tree().get_nodes_in_group("Persist")
	for a in actors:
		new_save_data[get_path_to(a)] = a.get_save_data()
	return new_save_data

func _init():
	save_data = ProjectSettings.get_setting("global/save_data")
	hud = hud.instance()
	hud.name = "HUD"
	add_child(hud)

func _ready():
	print("level ready")

	if save_data.size() == 0:
		_add_player()
		if $PlayerSpawn != null:
			$Player.set_position($PlayerSpawn.position)
			$PlayerSpawn.queue_free()
	else:
		print("load save: "+str(save_data))
		for node in save_data:
			var new_node = null
			var node_data = save_data[node]
			if node_data.has("type"):
				print("node type: "+node_data["type"])
				if node_data["type"] == "player":
					new_node = players[node_data["name"]].instance()
					new_node.name = "Player"
					new_node.health = node_data["health"]
					new_node.equipment = node_data["equipment"]
					new_node.backpack = node_data["backpack"]
					new_node.climbing = node_data["climbing"]
					add_child(new_node)
					new_node.set_position(node_data["position"])
					new_node.set_owner(self)
					$PlayerSpawn.queue_free()
				elif node_data["type"] == "lever":
					get_node(node).state = node_data["state"]
					get_node(node).emit_signal("LeverChanged")
	

	pause_mode = Node.PAUSE_MODE_PROCESS
	get_tree().paused = false
	set_health_bar() 

func _add_player():
	if $Player == null:
		var player = players[current_player].instance()
		player.name = "Player"
		add_child(player)
		player.set_owner(self)


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

