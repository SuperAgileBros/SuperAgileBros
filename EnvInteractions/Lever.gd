extends Area2D

export var state = '0'

func _ready():
 
	if state == '0':
	   $"Sprite/Lever-shaft".flip_h = false
	else:
	   $"Sprite/Lever-shaft".flip_h = true
	
func _process(delta):
	if self.overlaps_body(get_parent().get_parent().get_node("Player")) and Input.is_action_just_pressed("character_attack"):
		print("lever turned")
		if state == '0':
			state = '1'
		else:
			state = '0'
		Signal.LeverChanged()
	if state == '0':
		$"Sprite/Lever-shaft".flip_h = false
	else:
		$"Sprite/Lever-shaft".flip_h = true
		
		
		
		
