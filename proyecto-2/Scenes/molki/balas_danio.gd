extends Area2D

@export var velocidad: float = 600.0
@export var daño_jugador: int = 15
var direccion: Vector2 = Vector2.RIGHT 

func _physics_process(delta: float) -> void:
   
	global_position += direccion * velocidad * delta


func _ready() -> void:
	await get_tree().create_timer(3.0).timeout 
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if body.has_method("take_damage"):
			body.take_damage(daño_jugador)
			queue_free() 
