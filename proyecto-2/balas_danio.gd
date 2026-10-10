extends CharacterBody2D

var direction: float = 0
var speed: float = 800
var direccion = Vector2.ZERO
var damage = 20

func _physics_process(delta):
	#position += direccion * speed * delta
	rotation=direction
	#var velocity = Vector2(speed,0).rotated(direction) * delta
	position += Vector2.RIGHT.rotated(rotation) * speed * delta
	global_position += velocity 
	
	var choque = move_and_collide(velocity * delta)
	if choque:
		queue_free()
		var alChocar = choque.get_collider()
		if alChocar.has_method("Damage"):
			alChocar.Damage(damage)

	move_and_slide()
