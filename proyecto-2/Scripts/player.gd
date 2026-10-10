extends Jugador

@onready var vida: TextureProgressBar = $CanvasLayer/vida
@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var saltosfx: AudioStreamPlayer = $saltosfx
var coin_label: Label
var can_move: bool = true
var ground_pound_velocity = 300
var coin_collected = 0

func _ready() -> void:
	vida.value = health
	add_to_group("Jugadores")
	coin_label = get_tree().current_scene.find_child("Label", true, false) as Label
	if coin_label:
		coin_label.text = "Monedas: " + str(coin_collected)
func _physics_process(_delta: float) -> void:
	var direction := Input.get_axis("Left","Rigth")
	if not is_on_floor():
		velocity.y += GRAVITY
	if Input.is_action_just_pressed("salto"):
		$saltosfx.play()
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
	
	for i in get_slide_collision_count():
		var colision = get_slide_collision(i)
		var colider = colision.get_collider()
		if colider is TileMapLayer and colider.name == "Pinchos":
			morir()



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
			
		else:
			sprite.play("idle")
		return

	if direction != 0:
		sprite.play("walk")
	else:
		sprite.play("idle")

func take_damage(cantidad):
	super(cantidad)
	vida.value = health
	if health <= 0:
		morir()

func rebote():
	velocity.y  += EMPUJE

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("coin"):
		set_count(coin_collected + 1)
		print(coin_collected)

	if coin_collected % 5 == 0:
		gain_life()

func gain_life():
	vida.value += 25

func set_count(new_coin_count: int) -> void:
	coin_collected = new_coin_count
	coin_label.text = "Monedas: " + str(coin_collected)
