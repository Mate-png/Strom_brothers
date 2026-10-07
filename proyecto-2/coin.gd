extends Area2D

func _ready() -> void:
	pass 
func _process(delta: float) -> void:
	pass

func _on_area_entered(area: Area2D) -> void:
	queue_free()
