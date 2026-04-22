extends Node2D
class_name Entity2D

@export var components: Array[Component] = []

func _notification(what):
	match what:
		NOTIFICATION_READY:
			set_process(true)
			set_physics_process(true)
			for component in components:
				component._ready(self)
		NOTIFICATION_PREDELETE:
			for component in components:
				component.predelete.emit(self)
		NOTIFICATION_PROCESS:
			for component in components:
				if component.enabled:
					component._process(self, get_process_delta_time())
		NOTIFICATION_PHYSICS_PROCESS:
			for component in components:
				if component.enabled:
					component._physics_process(self, get_physics_process_delta_time())

func add_component(component: Component):
	assert(component is Component, "Component must be Component")
	components.append(component)
	component.start(self)

func pop_component(component: Component):
	component.on_predelete.emit(self)
	components.erase(component)

func pop_component_at(pos: int):
	components[pos].on_predelete.emit(self)
	components.pop_at(pos)

func find_component(type: Variant):
	assert(type is Component, "Type must be of Component")
	for component in components:
		if is_instance_of(component, type):
			return component
