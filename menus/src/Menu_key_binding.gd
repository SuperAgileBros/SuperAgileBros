extends Control

var can_change_key = true
var action_string
var actions = ""

var ControlerTab = preload("res://menus/ui/Controler_tab.tscn")

func _ready():
	actions = InputMap.get_actions()
	var joypads = Input.get_connected_joypads()
	var newTab = ControlerTab.instance()
	var keyboard_actions = []
	var controller_actions = []

	for action in actions:
		var action_events = InputMap.get_action_list(action)
		for event in action_events:
			if event is InputEventKey:
				keyboard_actions.append(action)
			elif event is InputEventJoypadButton:
				controller_actions.append(action)
	newTab.name = "Keyboard"
	newTab.actions = keyboard_actions
	add_child(newTab)
	for joypad in joypads:
		newTab = ControlerTab.instance()
		newTab.actions = controller_actions
		newTab.name = Input.get_joy_name(joypad) + " " + str(joypad)
		add_child(newTab)
