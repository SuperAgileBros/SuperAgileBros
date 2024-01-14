extends "res://actors/src/Bee.gd"

func _init():
	damage = 10
	proximity_range = 1000
	
func die():
	get_parent().throphy[0] = true
	queue_free()
