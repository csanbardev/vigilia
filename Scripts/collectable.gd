extends Node2D

@export var item: Item = null : 
	set(value):
		item = value
		if value != null:
			$CollectableSprite.texture = value.texture 

var is_player_on_area:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and is_player_on_area:
		var collectedItems = get_tree().current_scene.get_node("Player").get_node("CollectedItems")
		collectedItems.add_item(item)
		queue_free()


func _on_collectable_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_player_on_area = true


func _on_collectable_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_player_on_area = false
		
