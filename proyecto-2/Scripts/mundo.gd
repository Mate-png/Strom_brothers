extends Node

var Musica = preload("res://Art/Audio/workout.ogg")
@onready var pausa: Control = $Camara/Camera2D/Pausa


func _process(_delta: float) -> void:
	if !$AudioStreamPlayer.is_playing():
		$AudioStreamPlayer.stream = Musica
		$AudioStreamPlayer.play()


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("cerrar"):
		pausa.visible = true
		get_tree().paused = true
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
