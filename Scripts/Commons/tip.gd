extends Node

var is_player_on_area:bool = false
var tip_played:bool = false
var dialogue_start_flag:bool = false
signal dialogue_start_activate

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("interact") and is_player_on_area:
		DialogueManager.show_dialogue_balloon(dialogue_resource, dialogue_start)
		if !dialogue_start_flag:
			dialogue_start_flag = true
			emit_signal("dialogue_start_activate")
	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_player_on_area = true


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_player_on_area = false
