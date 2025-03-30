extends PanelContainer

@onready var label = $Label

func show_tooltip(item_data, position):
	label.text = "%s\n%s" % [item_data["name"], item_data["stats"]]
	global_position = position
	show()

func hide_tooltip():
	hide()
