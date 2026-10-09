extends StaticBody2D

var lazer_scene  = preload("res://Scenes/obstaculos/balas/laze_dw.tscn")
@export var timepo_disparo: float = 0.3
@export var activo = true

@onready var marker: Marker2D = $Marker2D

@onready var disparo_tiempo: Timer = $disparo_tiempo
@onready var visible_notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

func _ready() -> void:
	disparo_tiempo.wait_time = timepo_disparo
	disparo_tiempo.timeout.connect(disparar)

	visible_notifier.screen_entered.connect(func(): if activo: disparo_tiempo.start())
	visible_notifier.screen_exited.connect(func (): disparo_tiempo.stop())

func disparar():
	if not activo or not lazer_scene:
		return
		
	var proyectil = lazer_scene.instantiate()
	proyectil.global_position = marker.global_position
	proyectil.global_rotation = global_rotation
	get_tree().current_scene.add_child(proyectil)

func deshabilitar() -> void:
	activo = false


func habilitar() -> void:
	activo= true
