extends Player

var recepies_common = {
	["wooden stick","wooden stick","rope"]: "wooden sword",
	["wooden stick","rope","rope"]: "bow",
	["wooden stick","wooden stick","stone"]: "hammer",
	["iron pipe","wooden stick","hammer"]: "iron hammer",
	["iron pipe","iron pipe","iron pipe"]: "iron club",
	["wooden stick","wooden stick","snowball"]: "ice staff",
	["wooden stick","wooden stick","amber"]: "fire staff"
}

func _init():
	player_name = "KAM"

func _ready():
	pass

func _on_ActionTimer_timeout():

	if backpack.size() < 3:
		return
	var bench = [backpack[0]["item_name"],backpack[1]["item_name"],backpack[2]["item_name"]]
	bench.sort()
	var creation = ""
	print(recepies_common.size())
	for recepie in recepies_common:
		print("recepie: ",recepie)
		var sorted_recepie = recepie.duplicate()
		sorted_recepie.sort()
		print("sorted_recepie: ",sorted_recepie)
		print("bench: ",bench)
		if sorted_recepie == bench:
			creation = recepies_common[recepie]
			print("creation: ",creation)
			break
	if items.has(creation):
		print("spawninig item: ",creation)
		creation = load(items[creation]).instance()
		spawn_item(creation)
		for _i in range(3):
			backpack.pop_front()
		emit_signal("update_hud")
		$Ability.play()
	else:
		$Fail.play()
