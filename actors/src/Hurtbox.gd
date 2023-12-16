extends Area2D
class_name Hurtbox

func _ready():
	connect("area_entered", self, "_on_area_entered")
	
func _on_area_entered(hitbox):
	
	if hitbox == null:
		print("hitbox is null")
		return
	if owner.has_method("take_damage"):
		print(owner.name + " damaged for " + str(hitbox.damage))
		owner.take_damage(hitbox.damage)
	if hitbox.owner != null:
		if hitbox.owner.has_method("work"):
			hitbox.owner.work()
		if hitbox is Player:
			hitbox.damage(owner.attack)
