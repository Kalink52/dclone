extends Control

@onready var health_bar = $HealthBar
@onready var spell_bars = {
	"fireball": $SpellContainer/FireballCooldown,
	"blizzard": $SpellContainer/BlizzardCooldown,
	"teleport": $SpellContainer/TeleportCooldown
}

var max_health = 100
var current_health = 100

func _ready():
	#print(UI: spell_bars)
	update_health_ui()
	reset_spell_cooldowns()

func update_health_ui():
	health_bar.value = (current_health / max_health) * 100

func set_health(value):
	current_health = clamp(value, 0, max_health)
	update_health_ui()

func reset_spell_cooldowns():
	for bar in spell_bars.values():
		bar.value = 0

func update_spell_cooldown(spell_name, cooldown_time, time_left):
	if spell_name in spell_bars:
		var percent = (time_left / cooldown_time) * 100
		spell_bars[spell_name].value = percent
