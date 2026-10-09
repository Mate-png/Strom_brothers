extends Control
@onready var anim_player: AnimationPlayer = $Label/AnimationPlayer 
func _ready() -> void:
	anim_player.play("new_animation")
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "new_animation":
		if is_instance_valid(anim_player):
			anim_player.stop()
		get_tree().change_scene_to_file("res://Scenes/mundo.tscn")
		queue_free()
		
