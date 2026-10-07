extends Camera2D
var velocidad = 20
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_right"):
		position.x += velocidad * delta
	if Input.is_action_just_pressed("ui_left"):
		position.x -= velocidad * delta
