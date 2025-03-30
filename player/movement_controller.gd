extends Node
class_name MovementController

var movement_calculator: MovementCalculator
var input_handler: InputHandler
var character: CharacterBody2D

# Target position for the character to move towards
var target_position: Vector2
var arrival_threshold: float = 10  # Distance threshold to consider the character "arrived"


func _ready():
	movement_calculator = get_node("../MovementCalculator")  # Adjust path if needed
	input_handler = get_node("../InputHandler")  # Adjust path if needed
	character = get_parent()  # Assuming this is attached to the character node
	input_handler.connect("target_position_updated", _on_target_position_updated)

func _process(delta):
	# Calculate the movement direction
	var velocity = movement_calculator.calculate_movement(character, target_position)

	# Check if the character has arrived at the target position
	if position_is_close_enough(character.position, target_position):
		# Stop the movement when the character arrives at the target
		velocity = Vector2.ZERO
		

	character.velocity = velocity
	character.move_and_slide()  # Handles delta internally

func position_is_close_enough(current_position: Vector2, target_position: Vector2) -> bool:
	return current_position.distance_to(target_position) < arrival_threshold

func _on_target_position_updated(target_pos):
	target_position = target_pos

func stop_movement():
	target_position = character.position
