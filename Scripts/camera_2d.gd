extends Camera2D

var target_position = Vector2.ZERO
const ACCELERATION_SMOOTHING = 20

@export var player : CharacterBody2D

func _process(delta: float) -> void:
	get_target()
	
	global_position = global_position.lerp(target_position, 1 - exp(-delta * ACCELERATION_SMOOTHING))
func get_target():
	target_position = player.global_position
