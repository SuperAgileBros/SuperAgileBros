extends Actor
class_name Player

var player_name = "Player"
export var climbing = false

onready var animation = $CollisionPolygon2D/Animation

export var attack_in_progress = false

const max_health = 100
var health = max_health

export var backpack = []
export var equipment = {
	"weapon": null,
	"armor": null,
	"accessory": null,
	"consumable": null
}
signal update_hud

var action_press_time = 0

func _ready():
	if connect("update_hud", get_parent().get_node("HUD"), "_on_update_hud"):
		pass
	else:
		print("not connected")
	emit_signal("update_hud")

func _process(delta):
	var hud_needs_update = false
	for i in range(backpack.size()):
		if is_instance_valid(backpack[i]) == false:
			backpack.remove(i)
			hud_needs_update = true
	for i in equipment.keys():
		if is_instance_valid(equipment[i]) == false:
			equipment[i] = null
			hud_needs_update = true
	if hud_needs_update:
		emit_signal("update_hud")

func _input(event):
	if event.is_action_pressed("character_action"):
		$ActionTimer.start()
	if event.is_action_released("character_action"):
		$ActionTimer.stop()
		$Ablility.stop()
	if event.is_action_pressed("character_attack"):
		_attack()
	if event.is_action_pressed("character_equip"):
		_equip()
	if event.is_action_pressed("character_throw"):
		_throw()
	if event.is_action_pressed("character_jump"):
		if is_on_floor() == true:
			$Jump.play()
func _equip():
	if backpack.size() > 0:
		if backpack[0].is_equipable:
			var item = backpack.pop_at(0)
			get_equipment(item)
			emit_signal("update_hud")
func _attack():
	if $Attack.playing == false:
		$Attack.play()
		attack_in_progress = true

		
func _throw():
	if backpack.size() > 0:
		var durability = backpack[0].item_durability
		var projectile = backpack.pop_at(0).duplicate()
		projectile.item_durability = durability
		projectile.global_position = $Hand.global_position
		projectile.set_rotation(0)
		if face_right:
			projectile.global_position.x += 20
			projectile.apply_central_impulse(Vector2(1000, 0))
		else:
			projectile.global_position.x -= 20
			projectile.apply_central_impulse(Vector2(-1000, 0))
		get_parent().add_child(projectile)
		emit_signal("update_hud")
		
func die():
	get_tree().change_scene("res://menus/Menu_main.tscn")

func _physics_process(_delta) -> void:
	
	var direction := get_direction()
	var sprite := get_child(0)
	
	
	if direction.x > 0 and face_right == false:
		face_right = true
		scale.x = -1
	if direction.x < 0 and face_right == true:
		face_right = false
		scale.x = -1

	#velocity = calculate_velocity(velocity, direction, speed)
	#velocity = move_and_slide(velocity, Vector2.UP, false, 4, 0.785398, false)
	
	if climbing == false:
		velocity = calculate_velocity(velocity, direction, speed)
		velocity = move_and_slide(velocity, Vector2.UP, false, 4, 0.785398, false)
	elif climbing == true:
		velocity = calculate_velocity(velocity, direction, speed)
		velocity = move_and_slide(velocity, Vector2.UP, false, 4, 0.785398, false)
		velocity.y = 300
		if Input.is_action_pressed("character_jump"):
			velocity.y = -400
		elif Input.is_action_pressed("character_down"):
			velocity.y = 400
			
	collision_process()
	player_animations()

func player_animations():
	if attack_in_progress == true:
		#check is attack animation is finished
		if animation.current_animation == "Attack":
			pass
		else:
			animation.play("Attack")
			if equipment["weapon"] != null:
				equipment["weapon"].work()
			emit_signal("update_hud")
			
	elif is_on_floor() == true and health > 0:
		if Input.is_action_pressed("character_right") or Input.is_action_pressed("character_left"):
			animation.play("Run")
			if $Walk.playing == false:
				$Walk.play()
		else:
			$Walk.stop()
			animation.play("Idle")
	elif is_on_floor() == false and health > 0:
		$Walk.stop()
		animation.play("Jump")
	elif health <= 0:
		$Walk.stop()
		animation.play("Death",false)

func collision_process():
	for i in range(get_slide_count()):
		var collision = get_slide_collision(i)
		if collision.collider is TileMap:
			pass
		elif collision.collider is Item and backpack.size() < 7:
			if collision.collider.item_name == "bullet":
				break
			pickup_item(collision.collider)
			$ItemPickUp.play()
			break
		#zachowaniwe pędu przy kolizji z Rigidbody2D
		if (collision.collider != null) and (collision.collider is RigidBody2D):
			collision.collider.apply_central_impulse(-collision.normal * 100)
	pass

func take_damage(damage):
	health -= damage
	$Hit.play()
	get_parent().set_health_bar()

func pickup_item(item):
	print("item picked up")
	if backpack.size() < 7:
		item.pickup()
		var durability = item.item_durability
		var item_to_backpack = item.duplicate()
		item_to_backpack.item_durability = durability
		backpack.append(item_to_backpack)
		item.queue_free()
		emit_signal("update_hud")
		
func get_equipment(item):
	var item_type = item.item_types[item.item_type]
	if item_type == "resource":
		item_type = "weapon"
	if equipment[item_type] != null:
		var equiped_item = equipment[item_type].duplicate()
		equiped_item.global_position = $Hand.global_position
		get_parent().add_child(equiped_item)

	equipment[item_type] = item


func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("character_right") - Input.get_action_strength("character_left"),
		-1.0 if Input.is_action_just_pressed("character_jump") and is_on_floor() else 1.0
	)

func calculate_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2
	) -> Vector2:
	var new_velocity = linear_velocity
	new_velocity.x = direction.x * speed.x
	new_velocity.y += gravity * get_physics_process_delta_time()
	if direction.y < 0:
		new_velocity.y = direction.y * speed.y
	return new_velocity

func _on_ActionTimer_timeout():
	pass # Replace with function body.


func _on_Animation_animation_started(anim_name:String):
	pass # Replace with function body.
