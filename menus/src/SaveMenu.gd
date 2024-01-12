extends Control


func _on_save_game_pressed():
	var packed_scene = PackedScene.new()
	packed_scene.pack(get_tree().get_current_scene())
	ResourceSaver.save("user://saves/"+$SaveName.text+".res", packed_scene)
	$Saves.update_saves()

func _on_Back_pressed():
	visible = false
	$"../VBoxContainer".visible = true
