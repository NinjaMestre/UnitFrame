extends Component
class_name Jump

@export var action := "ui_accept"
@export var strength := 10.0
@export var acceleration := 0.01
@export_group("Sound", "sound_")
@export var sound_enabled := false
@export var sound_path: NodePath

var velocity = 0.0

signal jump

var jumping := false
signal land_after_jump

func _ready(entity: Node2D):
	assert(entity is CharacterBody2D, "Entity2D must be a CharacterBody2D")
	assert(acceleration >= 0 and acceleration <= 1, "Acceleration must be between 0 and 1")

func _physics_process(entity: Node2D, delta: float):
	if entity.is_on_floor():
		velocity = 0.0
		if jumping:
			jumping = false
			land_after_jump.emit()
	if Input.is_action_just_pressed(action) and entity.is_on_floor():
		velocity = strength
		if sound_enabled:
			var sound: AudioStreamPlayer2D = entity.get_node(sound_path)
			assert(is_instance_of(sound, AudioStreamPlayer2D), "Sound Path must point to AudioStreamPlayer2D")
			sound.play()
		jumping = true
		jump.emit()
	entity.velocity.y = -velocity
	velocity = lerp(velocity, 0.0, acceleration)
	entity.move_and_slide()
