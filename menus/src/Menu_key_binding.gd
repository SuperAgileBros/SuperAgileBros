extends Control

var can_change_key = true
var action_string
var actions = ""

var ControlerTab = preload("res://menus/ui/Controler_tab.tscn")

func _ready():
	actions = InputMap.get_actions()
	var joypads = Input.get_connected_joypads()
	var newTab = ControlerTab.instance()
	newTab.name = "Keyboard"
	add_child(newTab)
	for joypad in joypads:
		newTab = ControlerTab.instance()
		newTab.name = Input.get_joy_name(joypad) + " " + str(joypad)
		add_child(newTab)
