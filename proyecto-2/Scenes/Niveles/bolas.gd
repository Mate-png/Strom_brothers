extends RigidBody2D

var puede_hacer_dano: bool = false

func _ready() -> void:
	if not is_in_group("Bolas"):
		add_to_group("Bolas")
		
	if not body_entered.is_connected(_on_body_entered):
		body_entered.connect(_on_body_entered)
		
	await get_tree().create_timer(0.2).timeout
	puede_hacer_dano = true

func _on_body_entered(body: Node2D) -> void:
	print("Chocó con: ", body.name)

	if body.is_in_group("Jugadores") or "Player" in body.name or "Jugador" in body.name:
		print("Jugador bateó la bola")
		puede_hacer_dano = true
		var fuerza_rebote = Vector2(600, -250)
		if body.has_node("AnimatedSprite2D"):
			var sprite = body.get_node("AnimatedSprite2D")
			if sprite.flip_h:
				fuerza_rebote.x = -600
		linear_velocity = Vector2.ZERO
		apply_impulse(fuerza_rebote)

	elif (body.is_in_group("Enemigos") or "Enemigo" in body.name or body.has_method("recibir_impacto_bola")) and puede_hacer_dano:
		print("¡Golpe al jefe confirmado!")
		if body.has_method("recibir_impacto_bola"):
			body.recibir_impacto_bola()
		queue_free()
