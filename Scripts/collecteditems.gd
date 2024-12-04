extends Control

var item: Item = null


func add_item (item: Item) -> void:
	
	var slots = $CanvasLayer/SlotsContainer.get_children()
	
	for slot in slots:
		# check if it's empty
		if slot.item == null:
			slot.item = item
			return
		
func remove_item(item_name: String) -> void:
	var slots = $CanvasLayer/SlotsContainer.get_children()
	
	for slot in slots:
		if slot.item != null and slot.item.name == item_name:
			slot.item = null
			slot.get_node("TextureRect").texture = null
func contains_item (item_name: String) -> bool:
	var slots = $CanvasLayer/SlotsContainer.get_children()
	
	for slot in slots:
		if slot.item != null and slot.item.name == item_name:
			return true
	return false
