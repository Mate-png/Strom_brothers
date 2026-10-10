extends CharacterBody2D

@export var player: Node2D
@export var frequency: float = 1.5
@export var amplitude: float = 10.0

@onready var _animated_sprite = $AnimatedSprite2D 
@onready var punto_disparo: Marker2D = $PuntoDisparo

const BOLA_ESCENA = preload("res://Scenes/Niveles/bolas.tscn")
const RAYO_ESCENA = preload("res://Scenes/molki/balas_danio.tscn")

var YOriginal: float
var time: float = 0

@export var tiempo_ataque: float = 3.0
var temporizador: float = 0.0

var golpes_recibidos: int = 0
const MAX_GOLPES: int = 3

func _ready() -> void:
	YOriginal = position.y
	if not is_in_group("Enemigos"):
		add_to_group("Enemigos")

func _process(delta: float) -> void:
	time += delta
	position.y = YOriginal + sin(time * frequency * TAU) * amplitude
	
	temporizador += delta
	if temporizador >= tiempo_ataque:
		temporizador = 0.0
		if get_tree().get_nodes_in_group("Bolas").size() == 0:
			disparar_bola_desde_enemigo()

func recibir_impacto_bola() -> void:
	golpes_recibidos += 1
	print("¡IMPACTO EXITOSO! Golpes: ", golpes_recibidos)
	
	temporizador = 0.0
	disparar_bola_desde_enemigo()
	
	if golpes_recibidos >= MAX_GOLPES:
		print("¡El jefe ha muerto a los 3 golpes!")
		queue_free()

func disparar_bola_desde_enemigo() -> void:
	if not BOLA_ESCENA: return
	
	var bola = BOLA_ESCENA.instantiate()
	get_tree().current_scene.add_child(bola)
	
	if punto_disparo:
		bola.global_position = punto_disparo.global_position
	else:
		bola.global_position = global_position
		
	if bola is RigidBody2D:
		var dir_x = -1 if randi() % 2 == 0 else 1
		bola.apply_impulse(Vector2(dir_x * 300, -100))
		print("¡Bola nueva lanzada!")

func _on_vision_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player = body

func _on_area_2d_body_entered(_body: Node2D) -> void:
	queue_free()
