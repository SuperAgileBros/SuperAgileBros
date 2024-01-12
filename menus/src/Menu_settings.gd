extends Control

var config = ConfigFile.new()

func _ready():
	rect_size = get_parent_area_size()
	if get_parent() is Popup:
		$Background.visible = false
	var err = config.load("user://settings.cfg")
	
func _on_Back_pressed():
	if get_tree().paused:
		get_tree().paused = false
	#_save_settings()
	get_tree().change_scene("res://menus/Menu_main.tscn")
	
func _save_settings():
	print()
	#print("saving settings:" + str(ProjectSettings.save()))
	#print("saving settings:" + str(ProjectSettings.save_custom("override.cfg")))
	print("saveing settings: " + str(config.save("user://settings.cfg")))
	print(config.to_string())
	
func get_config():
	return config


func _on_Save_pressed():
	_save_settings()
