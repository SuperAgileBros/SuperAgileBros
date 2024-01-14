extends "res://actors/src/Boar.gd"


func _init():
	damage = 10
	health = 50
	proximity_range = 1000
	
func die():
	get_parent().throphy[2] = true
	queue_free()
