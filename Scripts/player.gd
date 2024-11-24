extends CharacterBody2D
class_name Player

const SPEED = 300.0

var light_distance := 75.0

func _ready() -> void:
	$FlashLight.energy = 1.0

func _process(delta: float) -> void:
	# mouse position
	var mouse_position = get_global_mouse_position()
	
	# light pivot position, reference for flashlight rotation
	var pivot_position = $LightPivot.global_position
	
	# direction from pivot to mouse
	var direction_to_mouse = (mouse_position - pivot_position).normalized()
	
	# set light position around its pivot 
	var light_position = pivot_position + direction_to_mouse * light_distance
	$FlashLight.global_position = light_position
	
	# set angle of the flash light texture
	$FlashLight.rotation = direction_to_mouse.angle()

func _physics_process(delta: float) -> void:
	# Obtener la dirección de entrada en el eje X e Y para movimiento en 8 direcciones
	var input_vector := Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	)

	# Normalizar el vector de entrada para que la velocidad sea constante en diagonal
	if input_vector.length() > 0:
		input_vector = input_vector.normalized()

	# Actualizar la velocidad en base al vector de entrada y la velocidad configurada
	velocity = input_vector * SPEED
	
	if Input.is_action_just_pressed("ui_right"):
		$PlayerAnimation.play("Run_Right")
		
	if Input.is_action_just_pressed("ui_left"):
		$PlayerAnimation.play("Run_Left")
		
	if Input.is_action_just_pressed("ui_down"):
		$PlayerAnimation.play("Run_Down")
		
	if Input.is_action_just_pressed("ui_up"):
		$PlayerAnimation.play("Run_Up")

	# Mover al personaje
	move_and_slide()
