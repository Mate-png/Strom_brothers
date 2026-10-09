extends Area2D
const DAÑO = 25

func _on_body_entered(body: Node2D) -> void:
	var jugador = body
	if jugador.is_in_group("Jugadores"):
		if jugador.has_method("take_damage"):
			jugador.take_damage(DAÑO)
