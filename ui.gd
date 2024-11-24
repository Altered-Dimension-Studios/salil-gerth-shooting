extends Control

func _ready() -> void:
	SignalBus.boss_died.connect(_on_boss_died)
	SignalBus.player_died.connect(_on_player_died)
	
	
func _on_boss_died() -> void:
	$EndGameText.text = "YOU WIN!"
	$EndGameText.visible = true


func _on_player_died() -> void:
	$GameOver.play()
	$EndGameText.text = "GAME OVER"
	$EndGameText.visible = true
