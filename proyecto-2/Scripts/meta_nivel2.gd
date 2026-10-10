extends Area2D

@onready var player: CharacterBody2D =$"../Player"
@onready var player_2: CharacterBody2D =$"../Player2"

var player1_en_meta: bool = false
var player2_en_meta: bool = false

var jugadores_en_meta: Array[Node2D] = []

const JUGADORES_REQUERIDOS: int = 2

func comprobar_victoria():
	if player1_en_meta and player2_en_meta:
		print("¡Ambos jugadores llegaron a la meta! ¡Nivel completado!")
		get_tree().change_scene_to_file("res://Scenes/ganaste.tscn")

func _on_body_entered(body: Node2D) -> void:
	if body == player:
		player1_en_meta = true
		print("El jugador 1 llego a la meta")
	elif body == player_2:
		player2_en_meta = true
		print("El jugador 2 llego a la meta")
	comprobar_victoria()

func _on_body_exited(body: Node2D) -> void:
	if body == player:
		player1_en_meta = false
		print("El jugador 1 salio de la meta")
	elif body == player_2:
		player2_en_meta = false
		print("El jugador 2 salio de la meta")
