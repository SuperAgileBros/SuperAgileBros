extends Area2D
class_name Hurtbox

func _init():
	collision_layer = 32
	collision_mask = 32+16

func _ready():
	connect("area_entered", self, "_on_area_entered")
	
func _on_area_entered(hitbox: Hitbox):
	if hitbox == null:
		return
	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage)
