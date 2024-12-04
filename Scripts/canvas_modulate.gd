extends CanvasModulate



@onready var camera = get_viewport().get_camera_2d()

func _process(_delta):
	if camera:
		# Ajusta la modulación de color en función de la vista de la cámara
		var modulate_color = Color(0, 0, 0, 0.7)  # Oscurecer con un alfa de 0.7
		modulate = modulate_color
