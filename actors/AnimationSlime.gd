extends AnimationPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Animation_animation_finished(anim_name):
	#get_parent().get_tree().paused = true
	#if anim_name == "Death":
		get_parent().get_parent().queue_free()
		get_tree().change_scene("res://menus/Menu_main.tscn")
	#pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
