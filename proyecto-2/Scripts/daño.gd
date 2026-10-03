extends Area2D

const DAÑO = 25

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Jugadores") and body.has_method("take_damage"):
		body.take_damage(DAÑO)
