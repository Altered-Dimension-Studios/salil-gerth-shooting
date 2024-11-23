extends Panel

@onready var score_node = $MarginContainer/Score
const MIN_SCORE_LENGTH: int = 7

func _ready() -> void:
	SignalBus.enemy_died.connect(_on_enemy_died)


func _on_enemy_died() -> void:
	update_score(100)


func update_score(points: int) -> void:
	var score: int = int(score_node.text)
	score += points
	score_node.text = str(score).lpad(MIN_SCORE_LENGTH, '0')
