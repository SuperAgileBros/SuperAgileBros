extends AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Animation_animation_finished(anim_name):
	if anim_name == "Death":
		owner.die()
	elif anim_name == "Attack":
		print("Attack ended")
		var hand = owner.get_node("Hand")
		for item in hand.get_children():
			item.queue_free()
		owner.attack_in_progress = false

func _on_Animation_animation_started(anim_name):
	if anim_name == "Attack":
		var equiped_weapon = owner.equipment["weapon"]
		var weapon = load(equiped_weapon["item_path"]).instance()
		print("Attack is in progress")
		if weapon != null:
			print("weapon is " + weapon.item_name)
			var hand = owner.get_node("Hand")
			var rotation = weapon.equip_rotation
			var damage = equiped_weapon["damage"]
			var level = equiped_weapon["item_level"]
			
			weapon = weapon.get_node("Sprite").duplicate()
			if level > 1:
				weapon.frame = level - 1
			weapon.get_node("Hitbox").damage = damage
			weapon.rotation_degrees = rotation
			hand.add_child(weapon)
			
			if weapon.has_method("ranged_attack"):
				weapon.ranged_attack(damage)
			else:
				weapon.get_node("Hitbox").get_child(0).disabled = false
			print(hand.get_child_count())
	elif anim_name == "Death":
		owner.set_physics_process(false)
