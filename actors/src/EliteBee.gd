extends "res://actors/src/Bee.gd"

func _init():
	damage = 10
	proximity_range = 1000
	
func die():
	get_parent().throphy[0] = true
	get_parent().get_node("HUD")._on_update_hud()
	queue_free()
