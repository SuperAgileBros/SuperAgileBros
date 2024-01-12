extends ScrollContainer

var vbox = VBoxContainer.new()

func _ready():
	add_child(vbox)
	list_saves()

func list_saves():
	var save_files = Directory.new()
	if save_files.open("user://saves/") != 0:
		save_files.make_dir_recursive("user://saves/")
		save_files.open("user://saves/")
	save_files.list_dir_begin()
	var save_file = save_files.get_next()
	while save_file != "":
		if save_file.ends_with(".res"):
			var button = Button.new()
			button.text = save_file.replace(".res", "")
			button.connect("pressed", self, "_on_save_button_pressed", [save_file])
			vbox.add_child(button)
		save_file = save_files.get_next()

func _on_save_button_pressed(save_file):
	print("Save file selected: " + save_file)
	$"../SaveName".text = save_file.replace(".res", "")
func update_saves():
	for child in vbox.get_children():
		child.queue_free()
	list_saves()
