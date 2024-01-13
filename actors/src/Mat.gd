extends Player


func _init():
	player_name = "MAT"

func _ready():
	randomize()

func _on_ActionTimer_timeout():
	$Ablility.play()
	var keys = items.keys()
	var key = keys[randi() % keys.size()]
	print(key)
	var item = load(items[key]).instance()
	spawn_item(item)


