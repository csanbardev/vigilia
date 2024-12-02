extends StaticBody2D

class_name Shower
var is_player_in:bool = false
signal activation_changed(active)
var is_active: bool = false 
@onready var fog_sprite = get_parent().get_parent().get_node("Fog")
@export var number: int 



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and is_player_in:
		if $ShowerAnimation.animation == "Idle_On":
			$ShowerAnimation.play("Off")
			#$ShowerAnimation.play("Idle_Off")
			set_active(false)
			$ShowerRunning.stop()
			$ShowerStopping.play()
		else:
			$ShowerRunning.play()
			$ShowerAnimation.play("On")
			$ShowerAnimation.play("Idle_On")
			set_active(true)


func _on_shower_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_player_in = true


func _on_shower_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_player_in = false

func set_active(value: bool) -> void:
	if is_active != value:
		is_active = value
		emit_signal("activation_changed", is_active, number)
		_update_fog(is_active)

func _update_fog(activated: bool) -> void:
	if activated: 
		# Ajusta la opacidad de la neblina en la escena principal
		fog_sprite.modulate.a += .2
	else:
		fog_sprite.modulate.a -= .2
