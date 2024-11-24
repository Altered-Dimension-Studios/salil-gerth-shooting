extends Area2D
class_name Enemy

var health
const PLAYER_COLLISION_LAYER_INDEX: int = 1

func _on_area_entered(area: Area2D) -> void:
	
	if area.get_collision_layer_value(PLAYER_COLLISION_LAYER_INDEX):
		# TODO: add explosion gfx here
		queue_free()
		SignalBus.enemy_died.emit()
	
	$HitAnimation.play("get_damaged")
	health -= 1
	
	if health <= 0:
		# TODO: add explosion gfx here
		queue_free()
		SignalBus.enemy_died.emit()
		
		if is_in_group("boss"):
			SignalBus.boss_died.emit()
