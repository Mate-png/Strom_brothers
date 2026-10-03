extends Jugador

@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var vida: TextureProgressBar = $CanvasLayer/vida


@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	vida.value = health


func _physics_process(_delta: float) -> void:
	var direction := Input.get_axis("Left","Rigth")
	if not is_on_floor():
		velocity.y += GRAVITY
	if can_move == true :
		canvas_layer.visible = true
		handle_wall()
		handle_jump()
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
	if can_move == false:
		canvas_layer.visible = false 
		velocity.x = 0
	update_animation(direction)
	move_and_slide()

func update_animation(direction: float) -> void:
	# Orientación del sprite (voltear horizontalmente)
	if direction > 0:
		sprite.flip_h = true
	elif direction < 0:
		sprite.flip_h = false

	# Prioridad 1: Dash
	if is_dashing:
		sprite.play("dash")
		return

	# Prioridad 3: Aire (Salto y Caída)
	if not is_on_floor():
		if velocity.y < 0:
			sprite.play("jump")


	# Prioridad 4: Suelo (Caminar e Idle)
	if direction != 0:
		sprite.play("walk")
	else:
		sprite.play("idle")

func take_damage(cantidad):
	super(cantidad)
	vida.value = health
	if health <= 0:
		morir()
