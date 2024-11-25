extends StaticBody2D

var tv_dialogue
var item_added:bool = false
@export var event_controller: Area2D

func _ready():
	tv_dialogue = $TVDialogue
	tv_dialogue.connect("dialogue_start_activate", Callable(self, "_on_tv_start_activate"))
	event_controller.connect("custom_event", Callable(self, "start_tv_puzzle"))

func _process(delta: float) -> void:
	# check if tv was broken and finish puzzle
	if States.break_tv and !item_added:
		finish_tv_puzzle()

func _on_tv_start_activate(event_name: String):
	if event_name == "tv":
		$TVDialogue.dialogue_start = "tv_new_start"
	

func start_tv_puzzle(event_name: String) -> void:
	if event_name == "tv":
		$TVAnimation.play("On")

func finish_tv_puzzle() -> void:
	var collectedItems = get_tree().current_scene.get_node("Player").get_node("CollectedItems")
	# add crystal item 
	var crystal_item: Item = load("res://Resources/lamp.tres")
	collectedItems.add_item(crystal_item)
	item_added = true
	# remove tv dialogue
	$TVDialogue.queue_free()
