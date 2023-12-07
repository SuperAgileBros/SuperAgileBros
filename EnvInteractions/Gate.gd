extends Area2D
export var code = "0"
var codeFromLevers = ""
var levers = []
var lever

func _ready():
	lever = $Lever
	Signal.connect("LeverChanged",self,"CheckCode")
	#for lever in levers:
	#	print (lever.name, " ",lever.state)

func CheckCode():
	var codeFromLever = ""
	print ("testttt")
	#for lever in levers:
	codeFromLevers = lever.state
	if code == codeFromLevers:
			$StaticBody2D/CollisionShape2D.disabled = true
			$Aniamtion.play("Open",false)
	else:
			$StaticBody2D/CollisionShape2D.disabled = false
			$Aniamtion.play("Open",false, -2.0)
