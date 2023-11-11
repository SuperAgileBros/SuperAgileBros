extends Tabs

export var actions = []
export var controller_name = ""
export var controller_id = -1
var KeyBinding = preload("res://menus/ui/Key_binding.tscn")

func _ready():
	var node_name = self.get_name()
	print(node_name)
	_set_keys(node_name)

func _set_keys(controller_name):
	var y_position = 0
	for i in actions:
		var key = KeyBinding.instance()
		key.get_node("Label").set_text(i)
		var grandchild = self.get_child(0).get_child(0)

		print("Key has children: ", key.get_child_count() > 0)  # Check if key has any children
		print("Grandchild is visible: ", grandchild.visible)  # Check if grandchild is visible

		grandchild.rect_min_size = Vector2(400, 600)  # Set a size of 400x600grandchild.add_child(key)
		print("Key is in tree: ", key.is_inside_tree())  # Check if key is in the scene tree

		print("Key position: ", key.rect_position)  # Check the position of key
		print("Grandchild size: ", grandchild.rect_min_size)  # Check the size of grandchild

		#y_position += key.rect_size.y
