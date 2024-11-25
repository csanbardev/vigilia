extends StaticBody2D

var tv_dialogue
var item_added:bool = false
@export var event_controller: Area2D
signal tv_off

func _ready():
	tv_dialogue = $TVDialogue
	tv_dialogue.connect("dialogue_start_activate", Callable(self, "_on_tv_start_activate"))
	event_controller.connect("custom_event", Callable(self, "start_tv_puzzle"))

func _process(delta: float) -> void:
	if !item_added:
		if check_item():
			States.has_tv_object = true
		if States.break_tv:
			finish_tv_puzzle()

func _on_tv_start_activate():
	$TVDialogue.dialogue_start = "tv_new_start"
	

func start_tv_puzzle(event_name: String) -> void:
	if event_name == "tv":
		$TVAnimation.play("On")
		$TVStaticSound.play()
func check_item() -> bool:
	var collectedItems = get_tree().current_scene.get_node("Player").get_node("CollectedItems")
	
	if collectedItems.contains_item("Plunger"):
		return true
	return false
	

func finish_tv_puzzle() -> void:
	var collectedItems = get_tree().current_scene.get_node("Player").get_node("CollectedItems")
	var crystal_item = load("res://Resources/crystal.tres")
	
	item_added = true
	stop_tv()
	# remove tv dialogue
	tv_dialogue.queue_free()
	
	# remove Plunger
	collectedItems.remove_item("Plunger")
	
	# add crystal item
	collectedItems.add_item(crystal_item)
	
	
func stop_tv() -> void:
	$TVStaticSound.stop()
	emit_signal("tv_off")
