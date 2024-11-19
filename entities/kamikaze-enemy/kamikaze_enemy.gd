extends Area2D

const PLAYER_COLLISION_LAYER_INDEX: int = 1 # TODO: move this in some global class
const SPEED = 300
var health = 3
var path_to_player_car: Vector2
var charged_up: bool = false


func _physics_process(delta: float) -> void:
	if charged_up: 
		position += path_to_player_car * SPEED * delta
	else:
		position += (path_to_player_car * SPEED * delta) * -1


func _on_area_entered(area: Area2D) -> void:
	
	if area.get_collision_layer_value(PLAYER_COLLISION_LAYER_INDEX):
		# TODO: add explosion gfx here
		queue_free()
	
	health -= 1
	if health <= 0:
		# TODO: add explosion gfx here
		queue_free()


func start_attack_timer():
	$AttackTimer.start()


func _on_attack_timer_timeout() -> void:
	path_to_player_car = (World.get_car_position() - global_position).normalized()
	await get_tree().create_timer(0.1).timeout
	charged_up = true
