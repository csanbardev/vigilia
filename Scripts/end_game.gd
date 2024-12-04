extends Control

func _ready() -> void:
	MenuMusic.play()

func _on_exit_pressed() -> void:
	get_tree().quit()
