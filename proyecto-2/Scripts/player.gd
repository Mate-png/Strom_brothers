extends Jugador

@onready var vida: TextureProgressBar = $CanvasLayer/vida
@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var can_move: bool = true
var ground_pound_velocity = 300


func _ready() -> void:
	vida.value = health

func _physics_process(_delta: float) -> void:
	var direction := Input.get_axis("Left","Rigth")
	if not is_on_floor():
		velocity.y += GRAVITY

	if can_move == true :

		canvas_layer.visible =true
		handle_wall()
		handle_jump()
		ground_pound()

		if wall_lock_timer<= 0.0:
			velocity.x = direction* SPEED
		else:
			velocity.x = lerp(velocity.x, direction * SPEED, 0.1)

		if Input.is_action_just_pressed("dash"):
			start_dash(direction)

		if is_dashing:
			velocity = dash_dir * DASH_SPEED
		elif wall_lock_timer > 0.0:
			pass
		else:
			velocity.x = direction * SPEED
		update_animation(direction)
	elif can_move == false:
		canvas_layer.visible =false
		velocity.x = 0
		sprite.play("idle")
	move_and_slide()


func ground_pound():
	if not is_on_floor() and Input.is_action_just_pressed("agacharse,pisoton"):
		velocity.y += ground_pound_velocity

func update_animation(direction: float) -> void:
	if direction > 0:
		sprite.flip_h = false
	elif direction < 0:
		sprite.flip_h = true

	if is_dashing:
		sprite.play("dash")
		return

	if not is_on_floor():
		if velocity.y < 0:
			sprite.play("jump")

	if direction != 0:
		sprite.play("walk")
	else:
		sprite.play("idle")

func take_damage(cantidad):
	super(cantidad)
	vida.value = health
	if health <= 0:
		morir()
