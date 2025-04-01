extends Button

#@onready var icon = $TextureRect
#@onready var label = $Label  # Add a Label node in Slot.tscn to show amounts

var item_data = null

func set_item(data):
	item_data = data
	icon.texture = load(data["icon_path"])
	#label.text = str(data["amount"]) if "amount" in data else ""

func has_item():
	return item_data != null
