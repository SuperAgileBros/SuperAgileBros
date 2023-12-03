extends Area2D
class_name Hurtbox

func _ready():
	connect("area_entered", self, "_on_area_entered")
	
func _on_area_entered(hitbox: Hitbox):
	
	if hitbox == null:
		print("hitbox is null")
		return
	if owner.has_method("take_damage"):
		print(owner.name + " damaged for " + str(hitbox.damage))
		owner.take_damage(hitbox.damage)
