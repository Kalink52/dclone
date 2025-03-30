extends Node2D

@export var damage_per_tick: int = 10
@export var tick_rate: float = 0.5  # Damage every 0.5s
@export var duration: float = 3.0  # Blizzard lasts for 3s

var enemies_in_area = []

func _ready():
	$Timer.wait_time = tick_rate
	$Timer.start()
	await get_tree().create_timer(duration).timeout  # Destroy after duration
	queue_free()

func _on_Timer_timeout():
	for enemy in enemies_in_area:
		if enemy.has_method("take_damage"):
			enemy.take_damage(damage_per_tick)

func _on_Area2D_body_entered(body):
	if body.has_method("take_damage") and body not in enemies_in_area:
		enemies_in_area.append(body)

func _on_Area2D_body_exited(body):
	if body in enemies_in_area:
		enemies_in_area.erase(body)
