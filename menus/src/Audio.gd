extends Tabs
var master_bus = 0
func _ready():
	master_bus = AudioServer.get_bus_index("Master")

	$GridContainer/MasterVolumeLevel.value = AudioServer.get_bus_volume_db(master_bus)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_MasterVolumeLevel_value_changed(value):
	print(AudioServer.get_bus_volume_db(master_bus))
	print(value)
	AudioServer.set_bus_volume_db(master_bus,value)
	pass # Replace with function body.
