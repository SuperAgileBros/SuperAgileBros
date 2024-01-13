extends Control

export var back_path = "res://menus/Menu_main.tscn"
var config = ConfigFile.new()

func _ready():
	if get_parent() is Popup:
		$Background.visible = false
# warning-ignore:unused_variable
	var err = config.load("user://settings.cfg")
	
func _on_Back_pressed():
	if back_path != "":
		if get_tree().paused:
			get_tree().paused = false
		#_save_settings()
		get_tree().change_scene(back_path)
	else:
		visible = false
		$"../VBoxContainer".visible = true
	
func _save_settings():
	for action in InputMap.get_actions():
		var events = InputMap.get_action_list(action)
		config.set_value("input", action, { "deadzone":InputMap.action_get_deadzone(action) ,"events":events})

	print("saving settings: " + str(config.save("user://settings.cfg")))
	print(config.to_string())
	
func get_config():
	return config


func _on_Save_pressed():
	_save_settings()
