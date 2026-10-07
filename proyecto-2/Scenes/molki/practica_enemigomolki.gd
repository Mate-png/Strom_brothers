extends Node2D
# 1. Asegúrate de apuntar al NODO PADRE que contiene TODOS los elementos de la UI
@onready var pantalla_inicio: Control = $UIprueba2 
@onready var boton_jugar: Button = $UIprueba2/Button

func _ready() -> void:
	if is_instance_valid(pantalla_inicio) and is_instance_valid(boton_jugar):
		pantalla_inicio.show()
		boton_jugar.pressed.connect(_on_button_pressed)

func _on_button_pressed() -> void:
	# Al ocultar el padre, se ocultan automáticamente TODOS sus nodos hijos
	pantalla_inicio.hide()
