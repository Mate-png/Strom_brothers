extends CharacterBody2D

#region constantes
const SPEED = 200
const JUMP_VELOCITY = -400.0
const DASH_DURATION = 0.2
const DASH_SPEED = 300.0

const GRAVITY = 30.0
const GRAVITY_WALL = 150.0
const WALL_JUMP_VELOCITY_Y = -520.0
const WALL_JUMP_VELOCITY_X = 350.0

const WALL_COYOTE_TIME= 0.12
const WALL_LOCK_TIME= 0.12
#endregion

#region  variables
var wall_coyote_timer= 0.0
var wall_lock_timer = 0.0
var last_wall_normal = 0.0

var can_move: bool = false
var is_dashing = false
var dash_dir: Vector2 = Vector2.ZERO
#endregion

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(_delta: float) -> void:
	
	
	var direction := Input.get_axis("Left","Rigth")
	if not is_on_floor():
		velocity.y += GRAVITY
	if can_move == true :
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
		velocity.x = 0
	update_animation(direction)
	move_and_slide()

func morir():
	print("mori2")
	get_tree().reload_current_scene()

func start_dash(dir: float):
	is_dashing = true
	if dir == 0.0:
		dash_dir = Vector2.RIGHT
	else:
		dash_dir = Vector2(dir, 0).normalized()
	
	await get_tree().create_timer(DASH_DURATION).timeout
	is_dashing = false


func update_timers(delta: float) -> void:
	if wall_coyote_timer >0.0:
		wall_coyote_timer -= delta
	if wall_lock_timer > 0.0:
		wall_lock_timer -= delta

func handle_wall():
	if not is_on_floor() and is_on_wall() and velocity.y > 0:
		velocity.y = GRAVITY_WALL
		wall_coyote_timer = WALL_COYOTE_TIME
		last_wall_normal = get_wall_normal().x


func handle_jump():
	if not Input.is_action_just_pressed("salto"):
		return
	if is_on_floor():
		velocity.y = JUMP_VELOCITY
	elif wall_coyote_timer > 0.0:
		velocity.y = WALL_JUMP_VELOCITY_Y
		velocity.x = last_wall_normal * WALL_JUMP_VELOCITY_X
		
		wall_lock_timer = WALL_LOCK_TIME 
		wall_coyote_timer = 0.0





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
