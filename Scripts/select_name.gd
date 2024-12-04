extends Control



func _on_name_text_submitted(new_text: String) -> void:
	if new_text != "":
		States.player_name = new_text
	get_tree().change_scene_to_file("res://Scenes/initial_cinematic.tscn")


func _on_acept_pressed() -> void:
	_on_name_text_submitted($Name.text)
