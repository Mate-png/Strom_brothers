extends Area2D


const DAÑO = 25
var direccion: Vector2
var fuerza = 500

func _physics_process(delta: float) -> void:

	position -= transform.y * fuerza * delta

func on_expire() -> void:
	destroy_lazer()

func destroy_lazer() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(DAÑO)
		on_expire()
	elif body.is_in_group("Paredes"):
		on_expire()
