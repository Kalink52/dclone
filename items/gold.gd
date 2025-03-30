extends loot_item

#@export var amount: int = 1

func _ready():
	item_name = "Gold"  # Set the default item name
	item_type = "Gold"  # Define this as a "Weapon"
	##icon = preload("res://path_to_sword_icon.png")  # Add the sword icon path
	description = "BUY SOMETHING"  # Description of the sword
	
func _process(delta: float):
	print($CollisionShape2D.disabled)
	
