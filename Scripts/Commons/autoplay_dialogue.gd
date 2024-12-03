extends Node

var is_player_on_area:bool = false
var tip_played:bool = false
var dialogue_start_flag:bool = false
signal dialogue_start_activate

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"
@export var auto_remove: bool = true
@export var dialogue_name: String

func _ready() -> void:
	if States.killed_dialogues.has(dialogue_name):
		queue_free()
	DialogueManager.connect("dialogue_ended", Callable(self, "_on_dialogue_closed"))


func init_dialogue () -> void:
	if !dialogue_start_flag:
		get_tree().get_first_node_in_group("Player").set_player_paused(true)
		
		DialogueManager.show_dialogue_balloon(dialogue_resource, dialogue_start)
		if !dialogue_start_flag:
			dialogue_start_flag = true
			emit_signal("dialogue_start_activate")
		
		

func _on_dialogue_closed(resource: DialogueResource) -> void:
	dialogue_start_flag = false
	# let player move
	get_tree().get_first_node_in_group("Player").set_player_paused(false)
	if auto_remove:
			States.killed_dialogues.append(dialogue_name)
			queue_free()
	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_player_on_area = true
		init_dialogue()

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_player_on_area = false
