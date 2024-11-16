extends Area2D

const bulletPath = preload('res://entities/bullet/bullet.tscn')


const SPEED: float = 300.0
const MIN_CLAMP_VECTOR: Vector2 = Vector2(100, 0)
var MAX_CLAMP_VECTOR: Vector2

func _ready() -> void:
	MAX_CLAMP_VECTOR = Settings.screen_size - Vector2(100, 0)
	$Sprite.play()


func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_just_pressed("shoot"):
		print('shoot')
		print($Node2D/Marker2D.global_transform)
		shoot()
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED
	
	position += velocity * delta
	position = position.clamp(MIN_CLAMP_VECTOR, MAX_CLAMP_VECTOR)
	$Node2D.look_at(get_global_mouse_position())

func shoot():
	var bullet = bulletPath.instantiate()
	
	get_parent().add_child(bullet)
	bullet.transform = $Node2D/Marker2D.global_transform
	
