extends StaticBody2D

var is_player_in_path:bool = false
var is_door_open:bool = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_player_in_path and Input.is_action_just_pressed("interact") and not is_door_open:
		if check_object():
			States.has_access_card = true
			#$EntranceMachineTip.queue_free()
			clear_object()
			$PathBlockedCollision.disabled = true
			$AnimatedSprite2D.play("Toggle")
			is_door_open = true


func _on_path_blocked_collision_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_player_in_path = true

func check_object() -> bool:
	var collectedItems = get_tree().current_scene.get_node("Player").get_node("CollectedItems")
	return collectedItems.contains_item("AccessCard")
	
func clear_object() -> void:
	var collectedItems = get_tree().current_scene.get_node("Player").get_node("CollectedItems")
	collectedItems.remove_item("AccessCard")
