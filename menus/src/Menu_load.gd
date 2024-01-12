extends Control

export var back_path = "res://menus/Menu_main.tscn"

func _on_load_game_pressed():
	#var packed_scene = load("user://saves/"+$SaveName.text+".res")

	get_tree().change_scene("user://saves/"+$SaveName.text+".res")


func _on_Back_pressed():
	if back_path != "":
		if get_tree().paused:
			get_tree().paused = false
		#_save_settings()
		get_tree().change_scene(back_path)
	else:
		visible = false
		$"../VBoxContainer".visible = true
