extends Component
class_name Gravity

@export var acceleration_speed := 0.01
@export var gravity := 8.0
var current_velocity := 0.0

func _ready(entity: Node2D):
	assert(entity is CharacterBody2D, "Entity2D must be a CharacterBody2D")
	assert(acceleration_speed >= 0 and acceleration_speed <= 1, "Acceleration Speed must be between 0 and 1")

func _process(entity: Node2D, delta: float):
	if not entity.is_on_floor():
		current_velocity = lerp(current_velocity, gravity, acceleration_speed)
	else:
		current_velocity = 0.0
	entity.velocity.y = current_velocity * delta
	entity.move_and_slide()
