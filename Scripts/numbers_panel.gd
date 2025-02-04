extends CanvasLayer


func _on_open_pressed() -> void:
	var numbers = collect_numbers()
	
	if check_numbers(numbers):
		get_tree().paused = false
		visible = false
		get_tree().change_scene_to_file("res://Scenes/end_game.tscn")
	else: 
		$Panel/WarningLabel.visible = true
	
func _on_cancel_pressed() -> void:
	get_tree().paused = false
	visible = false

func collect_numbers() -> Array:
	var numbers: Array = []
	for child in $Panel/BoxContainer.get_children():
		numbers.append(child.text.to_int())
	return numbers

func check_numbers(numbers: Array) -> bool:
	var code = States.exit_code
	
	# check if code is right
	for index in numbers.size():
		if numbers[index] != code[index]:
			# if some number fail, return false
			return false
	# code is right
	return true
