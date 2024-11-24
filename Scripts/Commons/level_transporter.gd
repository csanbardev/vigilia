extends Node2D
 
@export var new_level_name: String

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var level_manager = LevelManager.get_instance()
		if level_manager:
			level_manager.change_level_by_name(new_level_name)
