extends Node2D

@onready var player_1= $"../Jugadores/Player"
@onready var player_2= $"../Jugadores/Player2"
@onready var camera= $Camera2D

enum PLAYER{
	PLAYER1,
	PLAYER2
}

var jugador_actual: PLAYER = PLAYER.PLAYER1

@export var camera_speed= 5

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Cam_Swap"):
		if jugador_actual == PLAYER.PLAYER1:
			jugador_actual = PLAYER.PLAYER2
			player_2.can_move = true
		else:
			jugador_actual = PLAYER.PLAYER1
			player_1.can_move = true

func _process(delta: float) -> void:
	var target_position: Vector2
	match jugador_actual:
		PLAYER.PLAYER1:
			target_position = player_1.global_position
			player_2.can_move = false
		PLAYER.PLAYER2:
			target_position = player_2.global_position
			player_1.can_move = false
	
	camera.global_position = camera.global_position.lerp(target_position, camera_speed * delta)
