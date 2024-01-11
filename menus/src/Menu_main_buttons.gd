extends VBoxContainer

var tutorial = "res://lvls/Level_0_v2.tscn"
var new_game = "res://lvls/Level_0_v2.tscn"
var load_game = "res://lvls/Level_0.tscn"
var settings = "res://menus/Menu_settings.tscn"
var scene_paths={
	"tutorial":"res://lvls/Level_0_v2.tscn",
	"new game":"res://lvls/Level_0_v2.tscn",
	"load game":"res://lvls/Level_0.tscn",
	"settings":"res://menus/Menu_settings.tscn",
	"about" : "res://menus/Menu_about.tscn"
}

func _on_button_pressed(path_name):
	get_tree().change_scene(scene_paths[path_name])

func _on_quit_pressed():
	get_tree().quit()
