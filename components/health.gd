extends Component
class_name Health

enum LossType {
	DISABLED,
	CHANGE_SCENE,
	CHANGE_CONTROL_VISIBILITY
}

@export var max_health := 100.0
@export var current_health := 100.0
@export_group("Game Over", "loss_")
@export var loss_type = LossType.DISABLED
@export var loss_scene: PackedScene
@export var loss_control: NodePath

signal health_changed

func change(amount: float):
	current_health += amount
	health_changed.emit(amount)

func _process(entity: Node2D, delta: float):
	if current_health <= 0:
		match loss_type:
			LossType.CHANGE_SCENE:
				entity.get_tree().change_scene_to_packed(loss_scene)
			LossType.CHANGE_CONTROL_VISIBILITY:
				var control: Control = entity.get_node(loss_control)
				assert(control is Control, "Control must be Control")
				control.visible = true
