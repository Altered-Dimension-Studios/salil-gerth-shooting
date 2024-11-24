extends Area2D
class_name Enemy

var health
const PLAYER_COLLISION_LAYER_INDEX: int = 1
const PLAYER_BULLET_COLLISION_LAYER_INDEX: int = 2
var explode_sprite_node = preload("res://entities/enemy/explode_sprite.tscn")

func _ready() -> void:
	var explode_sprite = explode_sprite_node.instantiate()
	explode_sprite.visible = false
	add_child(explode_sprite)
	explode_sprite.animation_finished.connect(queue_free)
	

func _on_area_entered(area: Area2D) -> void:
	
	if area.get_collision_layer_value(PLAYER_COLLISION_LAYER_INDEX):
		health = 0
	elif area.get_collision_layer_value(PLAYER_BULLET_COLLISION_LAYER_INDEX):
		$HitAnimation.play("get_damaged")
		health -= 1
	
	if health <= 0:
		remove_child($CollisionShape2D)
		$AnimatedSprite2D.visible = false
		$ExplodeSprite.visible = true
		$ExplodeSprite.play("explode")
		SignalBus.enemy_died.emit()
		
		if is_in_group("boss"):
			SignalBus.boss_died.emit()
