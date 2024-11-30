extends StaticBody2D

var is_player_in_area: bool = false
@export var numbers_panel: PackedScene
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and is_player_in_area:
		$AnimatedSprite2D.play()
		$NumbersPanel.visible = true
		get_tree().paused = true
		
	if $NumbersPanel.visible == false:
		$AnimatedSprite2D.stop()

func _on_hub_computer_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_player_in_area = true

func _on_hub_computer_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_player_in_area = false
