extends Node2D

@export var dialogue_resource: DialogueResource
var dialogue_start: String = "initial_cinematic"

func _ready() -> void:
	DialogueManager.connect("dialogue_ended", Callable(self, "_on_dialogue_closed"))
	DialogueManager.show_dialogue_balloon(dialogue_resource, dialogue_start)

func _on_dialogue_closed(_resource: DialogueResource) -> void:
	get_tree().change_scene_to_file("res://Scenes/level_01.tscn")
