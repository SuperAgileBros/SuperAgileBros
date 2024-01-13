extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(AudioServer.bus_count):
		if ProjectSettings.has_setting("global/volume " + str(i)):
			AudioServer.set_bus_volume_db(i, ProjectSettings.get_setting("global/volume " + str(i)))
			ProjectSettings.clear("global/volume " + str(i))
