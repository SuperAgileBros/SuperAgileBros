extends Tabs

export var actions = []
export var controller_name = ""
export var controller_id = -1
export var can_change_keys = true

var KeyBinding = preload("res://menus/ui/Key_binding.tscn")

func _ready():
	self.name = controller_name
	#var scrollContainer = ScrollContainer.new()
	#var scrollContainer = get_node("ScrollContainer")
	#scrollContainer.anchor_bottom = 1
	#scrollContainer.anchor_right = 1
	#scrollContainer.margin_right = self.rect_size.x
	#scrollContainer.margin_bottom = self.rect_size.y
	#scrollContainer.rect_size = get_parent().rect_size
	
	#self.add_child(scrollContainer)

	#var vbox = VBoxContainer.new()
	#vbox.anchor_bottom = 1
	#vbox.anchor_right = 1
	#vbox.margin_right = self.rect_size.x
	#vbox.margin_bottom = self.rect_size.y
	#scrollContainer.add_child(vbox)
	var vbox = $ScrollContainer/VBoxContainer


	var character_actions = []
	var ui_actions = []
	for action in actions:
		if action.begins_with("character_"):
			character_actions.append(action)
		elif action.begins_with("ui_"):
			ui_actions.append(action)
	
	_set_keys(vbox, character_actions, "Character")
	
func _set_keys(vbox, action_list, title):
	var title_label = Label.new()
	title_label.set_text(title)
	vbox.add_child(title_label)
	for action in action_list:
		var key_binding = KeyBinding.instance()
		key_binding.action_name = action
		key_binding.controller_name = controller_name
		key_binding.controller_id = controller_id
		vbox.add_child(key_binding)
