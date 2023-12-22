extends Area2D
class_name Hurtbox

func _ready():
	connect("area_entered", self, "_on_area_entered")
	
func _on_area_entered(hitbox):
	
	if hitbox == null:
		print("hitbox is null")
		return
	if hitbox is Hitbox and owner.has_method("take_damage"):
		print(owner.name + " damaged for " + str(hitbox.damage) + " by " + str(hitbox.get_parent().get_parent().name))
		owner.take_damage(hitbox.damage)
		if owner.has_method("knockback"):
			owner.knockback(1000, hitbox.get_parent().get_parent().global_position)

	if hitbox.owner != null:
		if hitbox.owner.has_method("work"):
			hitbox.owner.work()
		if hitbox.owner.has_method("move_and_slide"):
			hitbox.owner.move_and_slide((hitbox.global_position - self.global_position)*100)
	if hitbox is Player:
		hitbox.take_damage(owner.attack)
