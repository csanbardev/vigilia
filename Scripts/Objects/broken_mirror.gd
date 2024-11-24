extends StaticBody2D

var is_player_on_area:bool = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and is_player_on_area:
		if check_object():
			$FixedSprite.disabled = false
			$BrokenSprite.disabled = true
			
			$BrokenMirrorArea2D.queue_free()
			clear_object()

func _on_broken_mirror_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"): 
		is_player_on_area = true


func _on_broken_mirror_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"): 
		is_player_on_area = false

func check_object() -> bool:
	var collectedItems = get_tree().current_scene.get_node("Player").get_node("CollectedItems")
	return collectedItems.contains_item("Lamp")
	
func clear_object() -> void:
	var collectedItems = get_tree().current_scene.get_node("Player").get_node("CollectedItems")
	collectedItems.remove_item("Lamp")
	
