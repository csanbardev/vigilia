extends Control



func _on_name_text_submitted(new_text: String) -> void:
	if new_text != null:
		States.player_name = new_text
	get_tree().change_scene_to_file("res://Scenes/level_01.tscn")
