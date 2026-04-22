extends Component
class_name CameraFollow

@export var node_path: NodePath
@export var follow_speed := 5.0

func _ready(entity: Node2D):
	assert(entity is Camera2D, "Entity2D must be Camera2D")
	assert(node_path, "Node Path is null")

func _process(entity: Node2D, delta: float):
	var node := entity.get_node(node_path)
	assert(node is Node2D, "Node must be Node2D")
	entity.global_position = entity.position.lerp(node.global_position, clamp(follow_speed * delta, 0, 1))
