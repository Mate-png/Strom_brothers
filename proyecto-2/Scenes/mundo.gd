extends Node

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("cerrar"):
		get_tree().quit()
