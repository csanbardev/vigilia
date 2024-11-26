extends ParallaxBackground

func _process(delta: float) -> void:
	var velocity: int = 10
	scroll_offset.x -= velocity * delta
