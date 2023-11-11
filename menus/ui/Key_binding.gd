extends HBoxContainer
class_name KeyBinding

export var action_name: String = ""
export var controller_name: String = ""
export var controller_id = -1

func _ready():
	self.get_node("Label").set_text(action_name.split("_")[1].capitalize())
	var bindings = InputMap.get_action_list(action_name)
	
	for binding in bindings:
		if controller_id == -1 and binding is InputEventKey:
			_add_button(binding, binding.as_text())
		elif controller_id != -1 and binding is InputEventJoypadButton:
			_add_button(binding, Input.get_joy_button_string(binding.button_index))
		elif controller_id != -1 and binding is InputEventJoypadMotion:
			_add_button(binding, Input.get_joy_axis_string(binding.axis))

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
