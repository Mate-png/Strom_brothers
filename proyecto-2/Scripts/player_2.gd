extends Jugador

@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var vida: TextureProgressBar = $CanvasLayer/vida

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


var can_move: bool = false

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
		update_animation(direction)

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
	elif can_move == false:
		canvas_layer.visible = false 
		velocity.x = 0
		sprite.play("idle")
	move_and_slide()

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
