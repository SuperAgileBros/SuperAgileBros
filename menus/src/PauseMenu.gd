extends VBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_SETTINGS_pressed():
	$"../MenuSettings".visible = true
	visible = false


func _on_MAIN_MENU_pressed():
		if get_tree().paused:
			get_tree().paused = false
		#_save_settings()
		get_tree().change_scene("res://menus/Menu_main.tscn")


func _on_SAVE_pressed():
	$"../SaveMenu".visible = true
	visible = false


func _on_LOAD_pressed():
	$"../LoadMenu".visible = true
	visible = false
