extends HBoxContainer
class_name KeyBinding

export var action_name: String = ""
export var controller_name: String = ""
export var controller_id = -1
var new_binding
var listening = false
var bindings = []

func _ready():
	self.get_node("Label").set_text(action_name.split("_")[1].capitalize())
	bindings = InputMap.get_action_list(action_name)
	
	for binding in bindings:
		if controller_id == -1 and binding is InputEventKey:
			_add_button(binding, binding.as_text())
		elif controller_id != -1 and binding is InputEventJoypadButton:
			_add_button(binding, Input.get_joy_button_string(binding.button_index))
		elif controller_id != -1 and binding is InputEventJoypadMotion:
			_add_button(binding, Input.get_joy_axis_string(binding.axis) + " " + str(binding.axis_value))

func _input(event):
	if listening:
		if _total_event_is_action(event):
			print("This key is already used")
			return
		elif controller_id == -1 and event is InputEventKey:
			InputMap.action_add_event(action_name, event)
			_add_button(event, event.as_text())
			_on_AddButton_pressed()
		elif controller_id != -1 and ( event is InputEventJoypadButton or event is InputEventJoypadMotion ):
			InputMap.action_add_event(action_name, event)
			if event is InputEventJoypadButton:
				_add_button(event, Input.get_joy_button_string(event.button_index))
				_on_AddButton_pressed()
			elif event is InputEventJoypadMotion:
				_add_button(event, Input.get_joy_axis_string(event.axis) + " " + str(event.axis_value))
				_on_AddButton_pressed()

func _total_event_is_action(event):
	var actions = InputMap.get_actions()
	var non_ui_actions = []

	for action in actions:
		if not action.begins_with("ui_"):
			non_ui_actions.append(action)	

	for action in non_ui_actions:
		if InputMap.event_is_action(event, action):
			if event is InputEventJoypadMotion:
				return _check_JoyMotion(event, action)
			return true
	return false

func _add_button(binding, binding_name):
	var button = Button.new()
	button.set_text(binding_name)
	button.name = binding.as_text()
	button.connect("pressed", self, "_on_button_pressed", [binding,button])
	self.add_child(button)

func _on_button_pressed(binding,button):
	InputMap.action_erase_event(action_name, binding)
	button.queue_free()

func _on_AddButton_pressed():
	var button = get_node("AddButton")
	if _can_change_keys():
		button.text = "Press a key..."
		button.enabled_focus_mode = 0
		_set_can_change_keys(false)
		listening = true
	elif listening:
		button.text = "+"
		
		listening = false
		_set_can_change_keys(true)

func _can_change_keys():
	return get_parent().get_parent().get_parent().can_change_keys
func _set_can_change_keys(value):
	get_parent().get_parent().get_parent().can_change_keys = value

func _check_JoyMotion(event, action):
	var bindings = InputMap.get_action_list(action)
	for binding in bindings:
		if binding is InputEventJoypadMotion:
			if binding.axis == event.axis and binding.axis_value * event.axis_value > 0.5:
				return true
