extends Control
@onready var perdiste: Label = $ColorRect/Perdiste
@onready var reiniciar: Label = $Button/Reiniciar


func _ready() -> void:
	perdiste.text = "Perdiste..."
	reiniciar.text = "Reintentar"

func _on_button_pressed() -> void:
	get_tree().reload_current_scene()
