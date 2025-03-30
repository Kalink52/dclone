extends Control

@export var slot_scene: PackedScene  # Drag `Slot.tscn` here
@export var max_slots: int = 108  
var gold_amount: int = 0  # Store gold count

@onready var grid = $GridContainer
@onready var gold_label = $HBoxContainer/GoldAmount  # Adjust path if needed

var slots = []

func _ready():
	for i in range(max_slots):
		var slot = slot_scene.instantiate()
		grid.add_child(slot)
		slots.append(slot)

	update_gold_display()  # Ensure Gold shows at start

func add_gold(amount: int):
	gold_amount += amount
	update_gold_display()

func update_gold_display():
	gold_label.text = str(gold_amount)
	
