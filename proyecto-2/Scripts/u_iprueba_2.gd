extends Control
@onready var boton_jugar: Button = $Button 
@onready var titulo: Label = $Label 
@onready var fondo: Control = $ColorRect 

func _ready() -> void:
	show()
	if is_instance_valid(boton_jugar):
		boton_jugar.pressed.connect(_on_button_pressed)

func _on_button_pressed() -> void:
	queue_free()
