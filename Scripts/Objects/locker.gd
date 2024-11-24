extends StaticBody2D

@export var is_special:bool = false

var is_player_on_area:bool = false
var locker_open:bool = false

func _ready() -> void:
	# only show tip message in special locker
	if !is_special:
		$Tip.queue_free()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and is_player_on_area and !locker_open:
		# remove collisions and dialogue
		$LockerCollision.queue_free()
		locker_open = true
		$Tip.queue_free()
		
		# locker must be up to player
		z_index = 110

func _on_locker_area_2d_body_entered(body: Node2D) -> void:
	if is_special and body.is_in_group("Player"):
		is_player_on_area = true
		
		if locker_open:
			z_index = 110


func _on_locker_area_2d_body_exited(body: Node2D) -> void:
	if is_special and body.is_in_group("Player"):
		is_player_on_area = false
		if locker_open:
			z_index = 30
