extends Tabs

const display_resolutions = [
	Vector2(1280, 720),
	Vector2(1366, 768),
	Vector2(1600, 900),
	Vector2(1920, 1080),
	Vector2(2560, 1440),
	Vector2(3200, 1800),
	Vector2(3840, 2160),
]

onready var resolution_dropdown := $"Panel/Display Resolution/OptionButton" as OptionButton
onready var config = $"../..".get_config()

func _ready():
	# Cache screen size into a variable
	var screen_size := OS.get_screen_size()
	var screen_setting = Vector2(ProjectSettings.get_setting("display/window/size/width"),ProjectSettings.get_setting("display/window/size/height"))
	if OS.window_fullscreen:
		$"Panel/Display Resolution/CheckBox".pressed = true
	# Add resolutions to the display resolution dropdown
	for resolution in display_resolutions:
		if resolution.x <= screen_size.x and resolution.y <= screen_size.y:
			resolution_dropdown.add_item(str(resolution.x) + "×" + str(resolution.y))
	resolution_dropdown.select(display_resolutions.bsearch(screen_setting))

func _on_display_resolution_change(id: int) -> void:
	config.set_value("display","window/size/width", display_resolutions[id].x)
	config.set_value("display","window/size/height", display_resolutions[id].y)

	get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D,SceneTree.STRETCH_ASPECT_KEEP,display_resolutions[id])
	


func _on_CheckBox_toggled(button_pressed):
	print("fullscreen:" + str(button_pressed))
	if button_pressed:
		config.set_value("display","window/size/fullscreen",true)
		OS.set_window_fullscreen(true)
	else:
		config.set_value("display","window/size/fullscreen",false)
		OS.set_window_fullscreen(false)
