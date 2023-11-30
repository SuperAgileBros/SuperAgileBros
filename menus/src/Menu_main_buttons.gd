extends VBoxContainer

var tutorial = "res://lvls/Level_tutorial.tscn"
var new_game = "res://lvls/Level_0_v2.tscn"
var load_game = "res://lvls/Level_0.tscn"
var settings = "res://menus/Menu_key_binding.tscn"

func _ready():
	get_node("TutorialButton").connect("pressed", self, "_on_button_pressed", [tutorial])
	get_node("NewGameButton").connect("pressed", self, "_on_button_pressed", [new_game])
	get_node("LoadGameButton").connect("pressed", self, "_on_button_pressed", [load_game])
	get_node("SettingsButton").connect("pressed", self, "_on_button_pressed", [settings])
	get_node("ExitButton").connect("pressed", self, "_on_quit_pressed")


func _on_button_pressed(path):
	get_tree().change_scene(path)

func _on_quit_pressed():
	get_tree().quit()
