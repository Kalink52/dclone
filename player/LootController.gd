extends Node

var inventory = {}

func collect_loot(loot):
	if loot.item_name in inventory:
		inventory[loot.item_name] += loot.amount
	else:
		inventory[loot.item_name] = loot.amount

	print("Picked up:", loot.amount, loot.item_name)
