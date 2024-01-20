extends "res://actors/src/Boar.gd"


func _init():
	damage = 10
	health = 50
	proximity_range = 1000
	
func die():
	get_parent().throphy[2] = true
	get_parent().get_node("HUD")._on_update_hud()
	queue_free()
