extends Area2D

@export var sound : AudioStream 

func _ready() -> void:
		$TemporalSoundsAudio.stream = sound
	
func _on_temporal_sounds_audio_finished() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$TemporalSoundsAudio.play()
