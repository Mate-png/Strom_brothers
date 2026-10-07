extends Node
class_name Lazer

const DAÑO = 25
var direccion: Vector2
var fuerza = 300
var is_active= true

func on_hit(target: CharacterBody2D) -> void:
	if target.has_method("take_damage"):
		target.take_damage(DAÑO)


func on_expire() -> void:
	destroy_lazer()

func destroy_lazer() -> void:
	queue_free()
