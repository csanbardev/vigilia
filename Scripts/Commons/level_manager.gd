extends Node2D
class_name LevelManager

var current_level: Level
static var _instance: LevelManager = null
@export var player: Player

func _ready() -> void:
	if _instance == null:
		_instance = self
	else:
		queue_free()  
	
	_get_current_level()
	current_level.set_player_position(player)


func change_level_by_name(level_name: String):
	if current_level.name == level_name:
		return
	
	if get_child_count() > 0:
		current_level.queue_free()

	current_level = _get_level_instance_by_key(level_name) as Level
	current_level.set_player_position(player)
	_set_level(current_level)
	
static func get_instance() -> LevelManager:
	return _instance
	
func _get_current_level() -> Level:
	if !get_child_count() > 0:
		print("Not level")
		return null
	current_level = get_child(0) as Level
	return current_level
	
func _set_level(level: Level):
	add_child(level)
	current_level = level

func _get_level_instance_by_key(level_name: String):
	var path = "res://Scenes/Areas/%s.tscn" % level_name  # Construye la ruta al archivo
	var scene_resource = load(path)  # Carga el recurso de la escena

	if scene_resource:
		return scene_resource.instantiate()  # Devuelve una instancia de la escena
	else:
		print("Error: No se pudo cargar la escena", level_name)
		return null
