extends Node2D

const SPAWN_OFFSET_X: int = 100
const SPAWN_OFFSET_Y: int = 100
const KAMIKAZE_ENEMY = preload("res://entities/kamikaze-enemy/kamikaze-enemy.tscn")
const TRUCK_ENEMY = preload("res://entities/truck-enemy/truck-enemy.tscn")
const TOP_RANGE = [0.2, 0.48]
const LEFT_SPAWN_POINT: float = 0.03
const RIGHT_SPAWN_POINT: float = 0.65
enum Spawns {LEFT_SPAWN, TOP_SPAWN, RIGHT_SPAWN}
var rng = RandomNumberGenerator.new()


func _on_spawn_timer_timeout() -> void:
	random_spawn()


func random_spawn():
	var spawn_selected = Spawns.keys()[randi() % Spawns.size()]
	if spawn_selected == Spawns.keys()[Spawns.LEFT_SPAWN]:
		spawn_left()
	elif spawn_selected == Spawns.keys()[Spawns.RIGHT_SPAWN]:
		spawn_right()
	elif spawn_selected == Spawns.keys()[Spawns.TOP_SPAWN]:
		spawn_top()


func spawn_top():
	var enemy = KAMIKAZE_ENEMY.instantiate()
	
	var enemy_spawn_location = $SpawnLocation
	enemy_spawn_location.progress_ratio = rng.randf_range(TOP_RANGE[0], TOP_RANGE[1])
	# Offset so the enemy doesn't just pop up on the screen due to texture size
	enemy_spawn_location.position.y -= SPAWN_OFFSET_Y
	enemy.position = enemy_spawn_location.position
	
	add_child(enemy)


func spawn_left():
	var enemy = TRUCK_ENEMY.instantiate()
	
	var enemy_spawn_location = $SpawnLocation
	enemy_spawn_location.progress_ratio = LEFT_SPAWN_POINT
	enemy_spawn_location.position.x -= SPAWN_OFFSET_X
	enemy.position = enemy_spawn_location.position
	enemy.set_transition_direction(Vector2(1, 0))
	
	add_child(enemy)


func spawn_right():
	var enemy = TRUCK_ENEMY.instantiate()
	# flip sprite
	enemy.transform.x *= -1
	
	var enemy_spawn_location = $SpawnLocation
	enemy_spawn_location.progress_ratio = RIGHT_SPAWN_POINT
	enemy_spawn_location.position.x += SPAWN_OFFSET_X
	enemy.position = enemy_spawn_location.position
	enemy.set_transition_direction(Vector2(-1, 0))
	
	add_child(enemy)


func _on_level_timer_timeout() -> void:
	print("spawn boss")
	$SpawnTimer.stop()
