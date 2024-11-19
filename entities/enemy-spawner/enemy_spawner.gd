extends Path2D

const SPAWN_OFFSET_Y: int = 100
const KAMIKAZE_ENEMY = preload("res://entities/kamikaze-enemy/kamikaze-enemy.tscn")
var rng = RandomNumberGenerator.new()

func _on_spawn_timer_timeout() -> void:
	var enemy = KAMIKAZE_ENEMY.instantiate()
	
	var enemy_spawn_location = $EnemySpawnLocation
	enemy_spawn_location.progress_ratio = rng.randf_range(0.0, 1.0)
	# Offset so the enemy doesn't just pop up on the screen due to texture size
	enemy_spawn_location.position.y -= SPAWN_OFFSET_Y
	enemy.position = enemy_spawn_location.position
	
	add_child(enemy)
	# TODO: add transition
	enemy.start_attack_timer()
