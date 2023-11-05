extends Actor

func _physics_process(delta: float) -> void:
    var direction: = Vector2(
        Input.get_action_strength("character_right") - Input.get_action_strength("character_left"),
        1.0
    )
    velocity = direction * speed
    velocity = move_and_slide(velocity)