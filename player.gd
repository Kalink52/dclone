extends CharacterBody2D
class_name Playerbase

@export var inventory: Node  # Drag `Inventory` node in Inspector

func _ready():
		add_to_group("player")  # Ensures the player is always in the group
		
func collect_loot(loot):
	if loot.item_type == "Gold":
		inventory.add_gold(loot.amount)
	else:
		var loot_data = {
			"name": loot.item_name,
			#"icon_path": "res://icons/" + loot.item_name + ".png",  # Example path
			#"amount": loot.amount
		}

		if inventory.add_item(loot_data):
			queue_free()  # Remove loot object after pickup

func get_inventory():
	return inventory
	
