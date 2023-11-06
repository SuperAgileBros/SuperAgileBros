extends Node2D
class_name Level

# Called when the node enters the scene tree for the first time.
func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS

func _process(_delta):
	if Input.is_action_just_pressed("menu"):
		if get_tree().paused:
			$Pause_menu.hide()
			get_tree().paused = false
		else:
			get_tree().paused = true
			$Pause_menu.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
