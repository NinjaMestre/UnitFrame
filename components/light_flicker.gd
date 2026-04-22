extends Component
class_name LightFlicker

@export var flicker_speed := 0.1
@export var flicker_intensity := 1.0

func _ready(entity: Node2D):
	assert(entity is Light2D, "Entity2D must be Light2D")
	assert(0 <= flicker_speed and flicker_speed <= 1, "Flicker Speed must be between 0 and 1")

func _process(entity: Node2D, delta: float):
	entity.energy = flicker_intensity * (sin(Time.get_ticks_msec() * flicker_speed) + 1) / 2
