extends Button

func _on_Back_pressed():
	if get_tree().paused:
		get_tree().paused = false
	get_tree().change_scene("res://menus/Menu_main.tscn")
