extends Timer

export var monster_scene = "res://actors/Slime1.tscn"

func _on_Timer_timeout():
	print("spawner timeout")
	var monster = load(monster_scene).instance()
	owner.get_parent().add_child(monster)
	monster.global_position = owner.global_position



func _on_Area2D_body_entered(body):
	if body is Player:
		start()


func _on_Area2D_body_exited(body):
	if body is Player:
		stop()
