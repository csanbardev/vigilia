extends Area2D

signal custom_event
@export var event_name: String
@export var delete_after: bool = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		emit_signal("custom_event", event_name)
		
		# delete node after signal emitted
		if delete_after:
			queue_free()
