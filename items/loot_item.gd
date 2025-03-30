
extends Area2D
class_name loot_item

@export var item_name: String
@export var item_type: String  # For example: "Weapon", "Armor", "Potion"
@export var icon: Texture  # Icon to represent the item in the inventory
@export var description: String  # Description of the item (optional)
@export var amount: int

func _ready():
	connect("body_entered", _on_body_entered)
	
func _on_body_entered(body):
	print(body)
	if body.name == "Player":  # Ensure only the player picks up items
		body.collect_loot(self)
		queue_free()  # Remove loot after pickup
