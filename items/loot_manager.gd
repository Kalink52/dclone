extends Node

@export var loot_item_scene: PackedScene
@export var possible_loot = {
	"Gold": { "type": "currency", "min": 10, "max": 100 },
	"Short Sword": { "type": "weapon", "quality": "normal" },
	"Wand of Frost": { "type": "weapon", "quality": "magic", "affixes": ["Cold Damage"] }
}

func drop_loot(position, is_boss = false):
	var roll = randi() % 100
	var item_key = possible_loot.keys().pick_random()
	var item_data = possible_loot[item_key]

	var loot = loot_item_scene.instantiate()
	loot.item_name = item_key
	loot.item_data = item_data  # Stores item properties

	if item_data["type"] == "currency":
		loot.amount = randi_range(item_data["min"], item_data["max"])

	loot.global_position = position
	get_tree().current_scene.add_child(loot)
