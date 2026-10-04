extends Node
class_name Nivel


var player1_en_meta: bool = false
var player2_en_meta: bool = false

var jugadores_en_meta: Array[Node2D] = []

var Musica = preload("res://Scenes/workout.ogg")

@onready var player: CharacterBody2D = $Player
@onready var player_2: CharacterBody2D = $Player2

func _process(_delta: float) -> void:
	if !$AudioStreamPlayer.is_playing():
		$AudioStreamPlayer.stream = Musica
		$AudioStreamPlayer.play()

const JUGADORES_REQUERIDOS: int = 2
