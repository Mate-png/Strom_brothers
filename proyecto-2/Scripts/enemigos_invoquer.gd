extends Node


const Enemigo_Escene = preload("res://Scenes/enemigos/enemigo2.tscn")

@onready var markers: Array[Marker2D] = [$Marker2D, $Marker2D2, $Marker2D3, $Marker2D4, $Marker2D5, $Marker2D6, $Marker2D7, $Marker2D8, $Marker2D9]

func _ready() -> void:
	for marker in markers:
		var instanciaEnemigo = Enemigo_Escene.instantiate()
		instanciaEnemigo.global_position = marker.global_position
		add_child(instanciaEnemigo)
