extends StaticBody2D

@export var showers: Array[Shower] = []
@export var mirror_position: String 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for shower in showers:
		shower.connect("activation_changed", Callable(self, "_on_shower_activation_changed"))
		_update_display(shower.is_active, shower.number)

func _on_shower_activation_changed(active: bool, shower:int) -> void:
	_update_display(active, shower)

func _update_display(active: bool, shower: int) -> void:
	if mirror_position == "left":
		if shower == 3 and active:
			$MirrorSprite.visible = false
			$MirrorLeftHalfSprite.visible = true
		elif shower == 2 and active and $MirrorLeftHalfSprite.visible:
			$MirrorLeftHalfSprite.visible = false
			$MirrorLeftFullSprite.visible = true
	elif mirror_position == "right":
		if shower == 1 and active:
			$MirrorSprite.visible = false
			$MirrorRightHalfSprite.visible = true
		elif shower == 2 and active and $MirrorRightHalfSprite.visible:
			$MirrorRightHalfSprite.visible = false
			$MirrorRightFullSprite.visible = true
