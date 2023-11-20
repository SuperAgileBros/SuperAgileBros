extends Node2D
class_name Level

var characterChooseVisible: bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	set_health_bar() 

func set_health_bar() -> void:
	$HealthBar.value = $Player.health

func _process(_delta):
	if Input.is_action_just_pressed("menu"):
		if get_tree().paused:
			$Menu_pause.hide()
			get_tree().paused = false
		else:
			get_tree().paused = true
			$Menu_pause.show()

	if Input.is_action_just_pressed("character_change_window") and not characterChooseVisible:
		if not $Character_choose.visible:
			get_tree().paused = true
			$Character_choose.show()
			characterChooseVisible = true

	elif Input.is_action_just_released("character_change_window") and characterChooseVisible:
			get_tree().paused = false
			$Character_choose.hide()
			characterChooseVisible = false

##	if Input.is_action_just_pressed("character_change"):   // Michał ne wywalaj jeszcze tego proszę :D
	#	if get_tree().paused: 
	#		$Character_choose.hide()
	#		get_tree().paused = false
	#	else:
	#		get_tree().paused = true
	#		$Character_choose.show()


