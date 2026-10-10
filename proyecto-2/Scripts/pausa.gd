extends Control

func _on_button_pressed() -> void:
	if get_tree().paused == true and visible == true:
		get_tree().paused = false
		visible = false

func _on_button_2_pressed() -> void:
	get_tree().quit()
