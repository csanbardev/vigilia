extends CharacterBody2D
class_name Player

const SPEED = 150.0
const ACCELERATION_SMOOTHING = 25

var light_distance := 120.0

func _ready() -> void:
	$FlashLight.energy = 1.0
	$FlashLight.visible = false

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

func _input(event: InputEvent) -> void:
	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				$FlashLight.visible = true
			else:
				$FlashLight.visible = false
			# plays clic sound
			$FlashLight/FlashLightClic.play()

func _physics_process(delta: float) -> void:
	# Obtener la dirección de entrada en el eje X e Y para movimiento en 8 direcciones
	var input_vector := Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	)

	# Normalizar el vector de entrada para que la velocidad sea constante en diagonal
	if input_vector.length() > 0:
		input_vector = input_vector.normalized()
	var target_velocity = input_vector * SPEED
	# Actualizar la velocidad en base al vector de entrada y la velocidad configurada
	velocity = velocity.lerp(target_velocity, 1 - exp(-delta * ACCELERATION_SMOOTHING))
	
	# Cambiar animaciones basadas en la entrada
	if input_vector.length() > 0:  # Si hay movimiento
		if Input.is_action_just_pressed("ui_right"):
			$PlayerAnimation.play("Run_Right")
		elif Input.is_action_just_pressed("ui_left"):
			$PlayerAnimation.play("Run_Left")
		elif Input.is_action_just_pressed("ui_down"):
			$PlayerAnimation.play("Run_Down")
		elif Input.is_action_just_pressed("ui_up"):
			$PlayerAnimation.play("Run_Up")
	else:  # Si no hay movimiento, se usa la animación Idle
		# Obtener la dirección del ratón con respecto al jugador
		var mouse_position = get_global_mouse_position()
		var direction_to_mouse = (mouse_position - global_position).normalized()
		
		# Obtener el ángulo entre la dirección hacia el ratón y la dirección del jugador
		var angle = direction_to_mouse.angle()

		# Determinar la dirección basándonos en el ángulo
		if angle >= -PI / 4 and angle < PI / 4:
			# Mirando a la derecha
			$PlayerAnimation.play("Idle")
			$PlayerAnimation.frame = 0
		elif angle >= PI / 4 and angle < 3 * PI / 4:
			# Mirando arriba
			$PlayerAnimation.play("Idle")
			$PlayerAnimation.frame = 3
		elif angle >= -3 * PI / 4 and angle < -PI / 4:
			# Mirando abajo
			$PlayerAnimation.play("Idle")
			$PlayerAnimation.frame = 1
		else:
			# Mirando a la izquierda
			$PlayerAnimation.play("Idle")
			$PlayerAnimation.frame = 2

	# Mover al personaje
	move_and_slide()
