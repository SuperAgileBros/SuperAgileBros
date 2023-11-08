extends Control

var can_change_key = false
var action_string
var actions = ""

func _ready():
	actions = InputMap.get_actions()
	_set_keys()
	

func _set_keys():
	for i in actions:
		if i.begins_with("character"):
			_bindingNode(i,InputMap.get_action_list(i)[0].as_text(),"Panel/ScrollContainer/VBoxContainer/VBoxCharacterBindings")

func _bindingNode(action,binding,parent):
	var container = HBoxContainer.new()
	
	container.add_child(Label.new())
	container.add_child(Button.new())
	
	container.get_child(0).text = action.split("_")[1]
	container.get_child(1).text = binding
	
	get_node(parent).add_child(container)
