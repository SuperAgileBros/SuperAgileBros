extends Control

func _ready():
	rect_size = get_parent_area_size()
	
func _on_Back_pressed():
	get_tree().change_scene("res://menus/Menu_main.tscn")
