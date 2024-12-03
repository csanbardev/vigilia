extends Node2D
class_name  Level



@export var player_initial_position_marker2D: Node2D
@export var player_hub_position_marker2D: Node2D


func set_player_position(player: Player):
	player.global_position = player_initial_position_marker2D.global_position
	
func set_player_hub_position(player: Player):
	player.global_position = player_hub_position_marker2D.global_position
