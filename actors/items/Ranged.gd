extends Sprite

export var bullet_scene = ""
export var bullet_velocity = 0

func ranged_attack(damage):
	print("ranged_attack")
	print(bullet_scene)
	var bullet = load(bullet_scene).instance()
	bullet.get_child(0).get_child(0).damage = damage
	add_child(bullet)
	bullet.gravity_scale = 0
	if get_parent().get_parent().face_right:
		bullet.apply_central_impulse(Vector2(bullet_velocity, 0))
	else:
		bullet.apply_central_impulse(Vector2(-bullet_velocity, 0))
		
	
