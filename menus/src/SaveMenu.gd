extends Control


func _on_save_game_pressed():
	var save_data := {}
	var actors := get_tree().get_nodes_in_group("Persist")
	for a in actors:
		save_data[get_path_to(a)] = a.get_save_data()

	var data_as_str = var2str(save_data)
	#var data_as_str = var2str(get_tree())

	var file = File.new()
	file.open("user://saves/"+$SaveName.text+".save", File.WRITE)
	file.store_string(data_as_str)
	file.close()
		
	$Saves.update_saves()

func _on_Back_pressed():
	visible = false
	$"../VBoxContainer".visible = true
