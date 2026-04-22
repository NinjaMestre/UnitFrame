extends Component
class_name KeyboardController

enum MovementType {
	ALL_DIRECTIONS,
	HORIZONTAL,
	VERTICAL
}

@export var speed := 1.0
@export var movement_type := MovementType.ALL_DIRECTIONS
@export_group("Actions")
@export var forward_action := "ui_up"
@export var backwards_action := "ui_down"
@export var left_action := "ui_left"
@export var right_action := "ui_right"
@export_group("Particles")
@export var particles_enabled := false
@export var particles_paths: Array[KeyboardControllerComponentParticle]

signal moved_horizontal
signal moved_vertical

var horizontal := false
var vertical := false

func _ready(entity: Node2D):
	assert(entity is CharacterBody2D, "Entity2D must be a CharacterBody2D")
	horizontal = movement_type == MovementType.ALL_DIRECTIONS or movement_type == MovementType.HORIZONTAL
	vertical = movement_type == MovementType.ALL_DIRECTIONS or movement_type == MovementType.VERTICAL

func _physics_process(entity: Node2D, delta: float):
	entity.velocity = Vector2.ZERO
	if Input.is_action_pressed(forward_action) and vertical:
		entity.velocity.y = -speed
		moved_vertical.emit()
	if Input.is_action_pressed(backwards_action) and vertical:
		entity.velocity.y = speed
		moved_vertical.emit()
	if Input.is_action_pressed(right_action) and horizontal:
		entity.velocity.x = speed
		moved_horizontal.emit()
	if Input.is_action_pressed(left_action) and horizontal:
		entity.velocity.x = -speed
		moved_horizontal.emit()
	
	if particles_enabled:
		for controller_particle in particles_paths:
			var particle_path := controller_particle.path
			var particle := entity.get_node(particle_path)
			assert(particle, "Particles are enabled, but no particles are set")
			assert(is_instance_of(particle, GPUParticles2D) or is_instance_of(particle, CPUParticles2D), "Particle Path must point to GPUParticles2D or CPUParticles2D")
			var emit: bool = entity.velocity.x != 0 or entity.velocity.y != 0
			if controller_particle.emit_only_while_on_floor:
				emit = emit and entity.is_on_floor()
			particle.emitting = emit
	
	entity.move_and_slide()
