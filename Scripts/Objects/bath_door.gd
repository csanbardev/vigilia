extends StaticBody2D

var player_on_area:bool = false
var is_open:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and player_on_area and not is_open:
		$BathDoorAnimation.play("Open")
		$BathDoorCollision.disabled = true
		is_open = true

func _on_bath_door_area_body_entered(body: Node2D) -> void:
	player_on_area = true


func _on_bath_door_area_body_exited(body: Node2D) -> void:
	player_on_area = false
