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

func _ready():
	# Cache screen size into a variable
	var screen_size := OS.get_screen_size()

	# Add resolutions to the display resolution dropdown
	for resolution in display_resolutions:
		if resolution.x < screen_size.x and resolution.y < screen_size.y:
			resolution_dropdown.add_item(str(resolution.x) + "×" + str(resolution.y))

	# Add a "Fullscreen" item at the end and select it by default
	resolution_dropdown.add_item("Fullscreen")
	if OS.window_fullscreen:
		resolution_dropdown.select(resolution_dropdown.get_item_count() - 1)
	else:
		resolution_dropdown.select(display_resolutions.bsearch(OS.window_size))

func _on_display_resolution_change(id: int) -> void:
	if id < resolution_dropdown.get_item_count() - 1:
		OS.set_window_fullscreen(false)
		OS.set_window_size(display_resolutions[id])
		# May be maximized automatically if the previous window size was bigger than screen size
		OS.set_window_maximized(false)
	else:
		# The last item of the OptionButton is always "Fullscreen"
		OS.set_window_fullscreen(true)
