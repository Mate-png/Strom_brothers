extends Area2D

var direction = 1
var start_position = 0
var walking_distance = 50
var speed = 20

func _ready():
	start_position = position.x

func _physics_process(delta):
	position.x += direction * speed * delta
	
	if (position.x >= start_position + walking_distance):
		direction = -1

	if (position.x <= start_position - walking_distance):
		direction = 1
