extends Panel

@onready var score_node = $MarginContainer/Score
@onready var lives_node = $MarginContainer/Lives
const MIN_SCORE_LENGTH: int = 7

func _ready() -> void:
	SignalBus.enemy_died.connect(_on_enemy_died)
	SignalBus.player_hit.connect(_on_player_hit)


func _on_player_hit(lives: int) -> void:
	lives_node.text[lives_node.text.length() - 1] = str(lives)


func _on_enemy_died() -> void:
	update_score(100)


func update_score(points: int) -> void:
	var score: int = int(score_node.text)
	score += points
	score_node.text = str(score).lpad(MIN_SCORE_LENGTH, '0')
