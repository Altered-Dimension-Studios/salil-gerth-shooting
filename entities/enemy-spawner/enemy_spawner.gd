extends Node2D

const SPAWN_OFFSET_X: int = 100
const SPAWN_OFFSET_Y: int = 100
const KAMIKAZE_ENEMY = preload("res://entities/kamikaze-enemy/kamikaze-enemy.tscn")
const TRUCK_ENEMY = preload("res://entities/truck-enemy/truck-enemy.tscn")
const SHOOTER_ENEMY = preload("res://entities/shooter-enemy/shooter-enemy.tscn")
const BOSS_ENEMY = preload("res://entities/helicopter/helicopter.tscn")
const TOP_RANGE = [0.2, 0.48]
const LEFT_SPAWN_POINT: float = 0.012
const RIGHT_SPAWN_POINT: float = 0.737
enum Spawns {LEFT_SPAWN, TOP_SPAWN, RIGHT_SPAWN, SHOOTER_SPAWN}
var rng = RandomNumberGenerator.new()


func _on_spawn_timer_timeout() -> void:
	random_spawn()

func _on_timer_masina_timeout() -> void:
	random_spawn_masina()

func random_spawn():
	var spawn_selected = Spawns.keys()[randi() % Spawns.size()]
	if spawn_selected == Spawns.keys()[Spawns.TOP_SPAWN]:
		spawn_top()
	if spawn_selected == Spawns.keys()[Spawns.SHOOTER_SPAWN]:
		spawn_top_shooter()
		
func random_spawn_masina():
	var spawn_selected = Spawns.keys()[randi() % Spawns.size()]
	if spawn_selected == Spawns.keys()[Spawns.LEFT_SPAWN]:
		spawn_left()
	elif spawn_selected == Spawns.keys()[Spawns.RIGHT_SPAWN]:
		spawn_right()


func spawn_top():
	var enemy = KAMIKAZE_ENEMY.instantiate()
	
	var enemy_spawn_location = $SpawnLocation
	enemy_spawn_location.progress_ratio = rng.randf_range(TOP_RANGE[0], TOP_RANGE[1])
	# Offset so the enemy doesn't just pop up on the screen due to texture size
	enemy_spawn_location.position.y -= SPAWN_OFFSET_Y
	enemy.position = enemy_spawn_location.position
	
	add_child(enemy)
	
func spawn_trucks(spawn_point: float, spawn_type: Spawns):
	var enemy = TRUCK_ENEMY.instantiate()
	
	var enemy_spawn_location = $SpawnLocation
	enemy_spawn_location.progress_ratio = spawn_point
	if(spawn_type == Spawns.LEFT_SPAWN):
		enemy_spawn_location.position.x -= SPAWN_OFFSET_X
		enemy.set_transition_direction(Vector2(1, 0))
	elif (spawn_type == Spawns.RIGHT_SPAWN):
		enemy_spawn_location.position.x += SPAWN_OFFSET_X
		enemy.set_transition_direction(Vector2(-1, 0))
	else:
		push_error("This shouldn't be happening!")
	enemy.position = enemy_spawn_location.position
	
	
	add_child(enemy)

func spawn_top_shooter():
	var enemy = SHOOTER_ENEMY.instantiate()
	
	var enemy_spawn_location = $SpawnLocation
	enemy_spawn_location.progress_ratio = rng.randf_range(TOP_RANGE[0], TOP_RANGE[1])
	enemy_spawn_location.position.y -= SPAWN_OFFSET_Y
	enemy.position = enemy_spawn_location.position
	
	add_child(enemy)

func spawn_left():
	spawn_trucks(LEFT_SPAWN_POINT, Spawns.LEFT_SPAWN)
	
func spawn_right():
	spawn_trucks(RIGHT_SPAWN_POINT, Spawns.RIGHT_SPAWN)
	
func spawn_boss():
	var enemy = BOSS_ENEMY.instantiate()
	add_child(enemy)
	#return

func _on_level_timer_timeout() -> void:
	print('spawn boss')
	spawn_boss()
	#$SpawnTimer.stop()
	$TimerMasina.stop()
