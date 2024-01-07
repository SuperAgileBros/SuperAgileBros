extends Control

func _ready():
	rect_size = get_parent_area_size()
	if get_parent() is Popup:
		$Background.visible = false
	
func _on_Back_pressed():
	if get_tree().paused:
		get_tree().paused = false
	get_tree().change_scene("res://menus/Menu_main.tscn")
