extends VBoxContainer

var scene_paths={
	"tutorial":"res://lvls/Level_0_v2.tscn",
	"new game":"res://lvls/Level_0_v2.tscn",
	"load game":"res://menus/Menu_load.tscn",
	"settings":"res://menus/Menu_settings.tscn",
	"about" : "res://menus/Menu_about.tscn"
}

func _on_button_pressed(path_name):
	get_tree().change_scene(scene_paths[path_name])

func _on_quit_pressed():
	get_tree().quit()
