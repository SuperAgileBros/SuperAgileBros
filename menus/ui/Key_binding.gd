extends HBoxContainer
class_name KeyBinding

export var action_name: String = ""
export var controller_name: String = ""
export var controller_id = -1
var new_binding
var listening = false
var can_change_keys = true
var bindings = []

func _ready():
	can_change_keys = get_parent().get_parent().get_parent().can_change_keys
	self.get_node("Label").set_text(action_name.split("_")[1].capitalize())
	bindings = InputMap.get_action_list(action_name)
	
	for binding in bindings:
		if controller_id == -1 and binding is InputEventKey:
			_add_button(binding, binding.as_text())
		elif controller_id != -1 and binding is InputEventJoypadButton:
			_add_button(binding, Input.get_joy_button_string(binding.button_index))
		elif controller_id != -1 and binding is InputEventJoypadMotion:
			_add_button(binding, Input.get_joy_axis_string(binding.axis))

func _input(event):
	if _total_event_is_action(event):
		print("This key is already used")
	elif listening:
		if controller_id == -1 and event is InputEventKey:
			InputMap.action_add_event(action_name, event)
			_add_button(event, event.as_text())
			_on_AddButton_pressed()
		elif controller_id != -1 and ( event is InputEventJoypadButton or event is InputEventJoypadMotion ):
			InputMap.action_add_event(action_name, event)
			if event is InputEventJoypadButton:
				_add_button(event, Input.get_joy_button_string(event.button_index))
				_on_AddButton_pressed()
			else:
				_add_button(event, Input.get_joy_axis_string(event.axis))
				_on_AddButton_pressed()
func _total_event_is_action(event):
	var actions = InputMap.get_actions()
	for action in actions:
		if InputMap.event_is_action(event, action):
			return true

func _add_button(binding, binding_name):
	var button = Button.new()
	button.set_text(binding_name)
	button.name = binding_name
	button.connect("pressed", self, "_on_button_pressed", [binding])
	self.add_child(button)

func _on_button_pressed(binding):
	InputMap.action_erase_event(action_name, binding)
	var button = get_node(binding.as_text())
	button.queue_free()

func _on_AddButton_pressed():
	var button = get_node("AddButton")
	if can_change_keys:
		button.text = "Press a key..."
		can_change_keys = false
		listening = true
	elif listening:
		button.text = "+"
		listening = false
		can_change_keys = true


