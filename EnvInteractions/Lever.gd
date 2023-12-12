extends Area2D

export var state = -1
signal LeverChanged



func LeverChanged():
	emit_signal("LeverChanged")
	
func _ready():
 
	if state == -1:
	   $"Sprite/Lever-shaft".flip_h = false
	else:
	   $"Sprite/Lever-shaft".flip_h = true
	
func _process(delta):
	if self.overlaps_body(get_parent().get_parent().get_node("Player")) and Input.is_action_just_pressed("character_attack"):
		print("lever turned")
		if state == -1:
			state = 1
		else:
			state = -1
		LeverChanged()
	if state == -1:
		$"Sprite/Lever-shaft".flip_h = false
	else:
		$"Sprite/Lever-shaft".flip_h = true
		
		
		
		
