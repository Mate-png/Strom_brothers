extends Node

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("cerrar"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
