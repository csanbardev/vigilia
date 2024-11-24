extends PanelContainer


@export var item: Item = null:
	set(value):
		item = value
		if value != null:
			$TextureRect.texture = value.texture
