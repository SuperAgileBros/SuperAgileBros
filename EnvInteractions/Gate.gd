extends Area2D
export var code = "0"
var codeFromLevers = -1
var levers = []
var lever

func _ready():
	for lever in self.get_children():
		if lever is Area2D:
			levers.append(lever)
			lever.connect("LeverChanged", self, "CheckCode")
			print("Added lever:", lever)
	#lever = $Lever
	#lever.connect("LeverChanged",self,"CheckCode")
	#for lever in levers:
	#	print (lever.name, " ",lever.state)
var sumState = 0
func CheckCode():
	#var allLeversActivated = true
	
	for lever in levers:
		codeFromLevers += lever.state
		print(lever.state)
	if codeFromLevers < sumState:
		$StaticBody2D/CollisionShape2D.disabled = true
		$Animation.play("Open", false)
		sumState = codeFromLevers
	else:
		$StaticBody2D/CollisionShape2D.disabled = false
		$Animation.play("Open", false, -2.0)
		sumState = codeFromLevers


