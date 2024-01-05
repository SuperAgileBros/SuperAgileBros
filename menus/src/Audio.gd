extends Tabs
var master_bus = 0
var game_bus = 0
var music_bus = 0

func _ready():
	print(AudioServer.bus_count)
	master_bus = AudioServer.get_bus_index("Master")
	print("Master bus: " + str(master_bus))
	game_bus = AudioServer.get_bus_index("Game")
	print("Game bus: " + str(game_bus))
	music_bus = AudioServer.get_bus_index("Music")
	print("Music bus: " + str(music_bus))

	$GridContainer/MasterVolumeLevel.value = db2linear(AudioServer.get_bus_volume_db(master_bus))
	$GridContainer/MasterVolumeLevel.connect("value_changed", self, "_on_VolumeLevel_value_changed", [master_bus, $GridContainer/MasterVolumeLevel])

	$GridContainer/GameVolumeLevel.value = db2linear(AudioServer.get_bus_volume_db(game_bus))
	$GridContainer/GameVolumeLevel.connect("value_changed", self, "_on_VolumeLevel_value_changed", [game_bus, $GridContainer/GameVolumeLevel])

	$GridContainer/MusicVolumeLevel.value = db2linear(AudioServer.get_bus_volume_db(music_bus))
	$GridContainer/MusicVolumeLevel.connect("value_changed", self, "_on_VolumeLevel_value_changed", [music_bus, $GridContainer/MusicVolumeLevel])

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_VolumeLevel_value_changed(value, id, sender):
	print(AudioServer.get_bus_volume_db(id))
	print(value)
	AudioServer.set_bus_volume_db(id,linear2db(value))
	sender.get_child(0).play()
	pass # Replace with function body.
