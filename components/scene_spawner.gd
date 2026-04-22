extends Component
class_name SceneSpawner

@export var seconds_to_spawn := 3.0
@export var set_position := true
@export var scene: PackedScene

var current_timer := seconds_to_spawn
func _process(entity: Node2D, delta: float):
	current_timer -= delta
	if current_timer > 0:
		return
	current_timer = seconds_to_spawn
	var instance := scene.instantiate()
	entity.get_tree().root.add_child(instance)
	instance.global_position = entity.global_position
