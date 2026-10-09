extends CharacterBody2D

@export var player: Node2D
@onready var _animated_sprite = $AnimatedSprite2D2 
@onready var maxHealth = 100
@onready var currentHealth: int = maxHealth
@onready var raycastleft = $RayCast2D
@onready var raycastright = $RayCast2D2
const DAÑO = 25
const SPEED = 70
var direction = 1

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	_animated_sprite.play()
	if raycastright.is_colliding():
		direction = -1
	if raycastleft.is_colliding():
		direction = 1	
	position.x += direction * SPEED * delta
	move_and_slide()
	#if player != null:
		#look_at(player.global_position)
		#var direction = (player.position - position)
		#rotation_degrees -= 90
		#velocity = direction * SPEED
		#move_and_slide()
		
func _process(_delta: float) -> void:
	var cuerpos = $Vision.get_overlapping_bodies()
	for cuerpo in cuerpos:
		if cuerpo.is_in_group("Player"):
			$RayCast2D.target_position = $RayCast2D.to_local(cuerpo.global_position)
			if $RayCast2D.get_collider() == cuerpo:
				if $Timer.is_stopped():
					danio()
				break

func Damage(cantidad):
	maxHealth -= cantidad
	if maxHealth <= 0:
		queue_free()
		
func danio():
	$Timer.start()
	
func _on_vision_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player = body


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Jugadores") and body.has_method("take_damage"):
		body.take_damage(DAÑO)

func _on_area_da_body_entered(body: Node2D) -> void:
	if body.has_method("rebote"):
		body.rebote()
		queue_free()


#func _on_area_da_player_body_entered(body: Node2D) -> void:
	#if body.is_in_group("Jugadores") and body.has_method("take_damage"):
		#body.take_damage(DAÑO)
