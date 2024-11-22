extends Enemy

const SPEED: int = 100
var transition_direction: Vector2

func _init():
	health = 5


func _process(delta: float) -> void:
	horizontal_transition(delta)


func set_transition_direction(direction: Vector2):
	transition_direction = direction


func horizontal_transition(delta: float):
	position += transition_direction * SPEED * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
