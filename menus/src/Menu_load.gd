extends Control

export var back_path = "res://menus/Menu_main.tscn"

func _on_load_game_pressed():
	var default_level = "res://lvls/Level_0_v2.tscn"
	var to_delete = get_tree().get_root().get_child(0)
	var file = File.new()
	file.open("user://saves/"+$SaveName.text+".save", File.READ)
	var save_data : Dictionary = str2var(file.get_as_text())
	file.close()
	ProjectSettings.set_setting("global/save_data",save_data)
	#default_level = default_level.instance()
	#default_level.save_data = save_data
	#print(str(default_level.save_data))
	#get_tree().get_root().add_child(default_level)
	#get_tree().get_root().remove_child(to_delete)
	print(get_tree().change_scene(default_level))


func _on_Back_pressed():
	if back_path != "":
		if get_tree().paused:
			get_tree().paused = false
		#_save_settings()
		get_tree().change_scene(back_path)
	else:
		visible = false
		$"../VBoxContainer".visible = true
