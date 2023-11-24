extends Camera2D

# Declare member variables here. Examples:
onready var player = $Player
var follow_speed : float = 5.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player:
		# Calculate the new position for the camera
		var new_position = player.global_position
		position = position.linear_interpolate(new_position, follow_speed * delta)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
