extends Control


func _on_save_game_pressed():
	var save_data:Dictionary = get_tree().get_nodes_in_group("Level")[0].get_save_data()

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
