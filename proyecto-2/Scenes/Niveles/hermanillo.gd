extends Sprite2D
@export var frequency: float = 1
@export var amplitude: float = 14
const SPEED = 70
var direction = 0
var YOriginal: float
var time : float = 0

func _ready() -> void:
	YOriginal = position.y

func _physics_process(delta: float) -> void:
	time += delta
	#var time = Time.get_ticks_msec() / 1000
	position.y = YOriginal + sin(time * frequency * TAU) * amplitude
