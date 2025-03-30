extends Node
class_name MovementCalculator

# Speed of movement
var speed = 200


func calculate_movement(character: CharacterBody2D, target_position: Vector2) -> Vector2:
	var direction = (target_position - character.position).normalized()
	return direction * speed 
