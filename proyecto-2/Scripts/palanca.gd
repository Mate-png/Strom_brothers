extends Area2D

@export var cañon: StaticBody2D
@export var interactuar: String = "interactuar"

var jugador_en_rango: bool = false
var activado: bool = false
@onready var sheet: Sprite2D = $Sheet




func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Jugadores"):
		jugador_en_rango = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Jugadores"):
		jugador_en_rango = false



func _unhandled_input(event: InputEvent) -> void:
	if jugador_en_rango and event.is_action_pressed("interacturar"):
		presionar_interruptor()

func presionar_interruptor():
	activado = !activado
	
	if activado:
		modulate = Color(0.3, 1.0, 0.3)
	else:
		modulate = Color(1.0, 1.0, 1.0)
	
	if cañon:
		if activado and cañon.has_method("deshabilitar"):
			cañon.deshabilitar()
		elif not activado and cañon.has_method("Habilitar"):
			cañon.habilitar()
		
