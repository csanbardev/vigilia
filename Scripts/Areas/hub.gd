extends Level

func _ready() -> void:
	if States.hub_transported:
		$FirstLore.queue_free()
