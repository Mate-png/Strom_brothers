extends Area2D
@onready var coinsfx: AudioStreamPlayer = %coinsfx

func _on_area_entered(_area: Area2D) -> void:
	%coinsfx.play()
	queue_free()
