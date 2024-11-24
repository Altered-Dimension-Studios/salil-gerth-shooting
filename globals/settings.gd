extends Node2D


var screen_size: Vector2


func _ready() -> void:
	screen_size = get_viewport_rect().size


func _on_bgm_finished() -> void:
	$BGM.play() # Replace with function body.
