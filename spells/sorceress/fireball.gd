extends Node2D

@export var speed: float = 600  # Speed of fireball
@export var damage: int = 30  # Damage dealt
var direction = Vector2.ZERO  # Direction of travel

func _ready():
	# Ensure the fireball moves towards the mouse position
	direction = (get_global_mouse_position() - global_position).normalized()

func _process(delta):
	global_position += direction * speed * delta  # Move fireball forward

func _on_Area2D_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)  # Call damage function if exists
	queue_free()  # Destroy fireball on impact



#func _ready():
	## Fireball should move in the direction the player is aiming
	#apply_impulse(Vector2.ZERO, global_position.direction_to(get_global_mouse_position()) * speed)
#
#func _on_impact():
	## Handle explosion here (e.g., damage enemies in area, play effects)
	#emit_signal("exploded")
	#queue_free()
#
#func _on_explode():
	## Apply damage to enemies within the explosion radius
	#var area = get_overlapping_bodies()
	#for body in area:
		#if body.is_in_group("enemy"):
			#body.take_damage(explosion_damage)  # Example function for damage
	#queue_free()
