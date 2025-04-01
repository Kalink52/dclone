extends Node2D

@export var fireball_scene : PackedScene  
@export var blizzard_scene : PackedScene  
@export var teleport_effect_scene : PackedScene  
@onready var ui = get_tree().current_scene.get_node("./Player/UI")
var movement_controller : MovementController
var player  # Reference to the player

# Cooldown dictionary to store spell cooldowns
var cooldowns = {
	"fireball": 2.0,   # 2 seconds cooldown
	"blizzard": 5.0,   # 5 seconds cooldown
	"teleport": 3.0    # 3 seconds cooldown
}

var cooldown_timers = {
	"fireball": 0,   # 2 seconds cooldown
	"blizzard": 0,   # 5 seconds cooldown
	"teleport": 0    # 3 seconds cooldown
	}  # Active cooldown timers

func _ready():
	player = get_parent()  # Assuming SpellController is a child of the Player
	movement_controller = get_node("../MovementController")

func _process(delta):
	for spell in cooldown_timers.keys():
		if cooldown_timers[spell] > 0:
			cooldown_timers[spell] -= delta
			ui.update_spell_cooldown(spell, cooldowns[spell], cooldown_timers[spell])
	
	
	if Input.is_key_pressed(KEY_3):
		cast_spell("fireball", fireball_scene)
	elif Input.is_key_pressed(KEY_1):
		cast_spell("blizzard", blizzard_scene)
	elif Input.is_key_pressed(KEY_2):
		cast_spell("teleport", teleport_effect_scene, true)

func get_mouse_position():
	return get_viewport().get_camera_2d().get_global_mouse_position()

#func cast_fireball():
	#print("cast_fireball")
	#var fireball = fireball_scene.instantiate()
	#fireball.global_position = player.global_position
	#get_tree().current_scene.add_child(fireball)
#
#func cast_blizzard():
	#print("cast_blizzard")
	#var blizzard = blizzard_scene.instantiate()
	#blizzard.global_position = get_mouse_position()  # Drop blizzard at mouse position
	#get_tree().current_scene.add_child(blizzard)
#
#func cast_teleport():
	#print("cast_teleport")
	#var teleport_effect = teleport_effect_scene.instantiate()
	#teleport_effect.global_position = get_mouse_position()
	#get_tree().current_scene.add_child(teleport_effect)
#
	#await get_tree().create_timer(0.3).timeout  # Wait for effect
	#player.global_position = get_global_mouse_position()
	#movement_controller.stop_movement()

func cast_spell(spell_name: String, spell_scene: PackedScene, is_teleport=false):
	if cooldown_timers[spell_name] > 0:
		print(spell_name + " is on cooldown: " + str(snapped(cooldown_timers[spell_name], 0.1)) + "s left")
		return  # Exit if the spell is on cooldown

	# Cast the spell
	var spell_instance = spell_scene.instantiate()
	spell_instance.global_position = player.global_position
	get_tree().current_scene.add_child(spell_instance)

	if is_teleport:
		await get_tree().create_timer(0.3).timeout  # Wait for teleport effect
		player.global_position = get_global_mouse_position()
		movement_controller.stop_movement()  # Stop movement after teleport

	# Apply cooldown
	cooldown_timers[spell_name] = cooldowns[spell_name]
