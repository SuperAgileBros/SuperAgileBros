extends Actor
class_name Enemy

export var health = 10

	
func take_damage(damage):
	var dmg_label = load("res://EnvInteractions/FadingTekst.tscn").instance()
	dmg_label.text = str(damage)
	add_child(dmg_label)
	dmg_label.get_child(0).play("Fade")
	if self.get_node("Hit") != null:
		$Hit.play()
	health = health - damage

func get_save_data():
	return {
		"type":get_class(),
		"position":get_global_position(),
		"health":health
	}
