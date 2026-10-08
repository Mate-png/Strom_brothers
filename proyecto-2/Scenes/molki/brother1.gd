extends CharacterBody2D
@onready var _animated_sprite = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _physics_process(delta: float) -> void:
	
	if Input.is_action_pressed("ui_right"):
		_animated_sprite.play("correr")
		$AnimatedSprite2D.flip_h = false
	else:
		_animated_sprite.play("quieto")
		
	if Input.is_action_pressed("ui_left"):
		_animated_sprite.play("correr")	
		_animated_sprite.flip_h = true	
		
	if Input.is_action_pressed("ui_accept"):
		_animated_sprite.play("saltar")
		
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():

		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
