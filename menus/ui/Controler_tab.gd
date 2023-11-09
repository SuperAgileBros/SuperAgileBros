extends Tabs

export var actions = []
var KeyBinding = preload("res://menus/ui/Key_binding.tscn")

func _ready():
	var node_name = self.get_name()
	print(node_name)
	_set_keys(node_name)

func _set_keys(controler_name):
	var y_position = 0
	for i in actions:
		var key = KeyBinding.instance()
		key.get_node("Label").set_text(i)
		key.rect_position = Vector2(0, y_position)
		self.add_child(key)
		y_position += key.rect_size.y