extends Control

var action_string
var actions = ""

var ControllerTab = preload("res://menus/ui/Controller_tab.tscn")


func _ready():
	actions = InputMap.get_actions()
	var joypads = Input.get_connected_joypads()
	var newTab = ControllerTab.instance()

	newTab.controller_name = "Keyboard"
	newTab.actions = actions
	add_child(newTab)
	for joypad in joypads:
		newTab = ControllerTab.instance()
		newTab.actions = actions
		newTab.controller_name = Input.get_joy_name(joypad)
		newTab.controller_id = joypad
		add_child(newTab)
	print("key binding size: " + str(rect_size))
