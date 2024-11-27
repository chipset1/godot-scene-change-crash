extends CharacterBody2D

var move_component

func _physics_process(delta: float) -> void:
	if move_component: 
		velocity = move_component.get_velocity(self)

	move_and_slide()
