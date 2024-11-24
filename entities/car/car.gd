extends Area2D
class_name Car

const bulletPath = preload('res://entities/bullet/bullet.tscn')

const NORMAL_SPEED: float = 550
const SHOOTING_SPEED: float = 200
const MIN_CLAMP_VECTOR: Vector2 = Vector2(25, 0)
var MAX_CLAMP_VECTOR: Vector2
var can_shoot: bool = true
var shoot_hold_time: float = 0.0
const INITIAL_FIRERATE: float = 0.3  
const MIN_FIRERATE: float = 0.1     
const FIRERATE_DECREASE_RATE: float = 0.05  

func _ready() -> void:
	self.position.y = Settings.screen_size.y - 50
	MAX_CLAMP_VECTOR = Settings.screen_size - Vector2(150, 0)
	$Sprite.play()

func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	var current_speed = NORMAL_SPEED
	
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	
	if Input.is_action_pressed("shoot"):
		if can_shoot:
			shoot()
		shoot_hold_time += delta
		current_speed = SHOOTING_SPEED
	else:
		shoot_hold_time = 0.0
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * current_speed
		if velocity.x > 0:
			velocity = velocity.normalized() * current_speed/1.75
	
	position += velocity * delta
	position = position.clamp(MIN_CLAMP_VECTOR, MAX_CLAMP_VECTOR)
	$Node2D.look_at(get_global_mouse_position())

func shoot():
	var bullet = bulletPath.instantiate()
	get_parent().add_child(bullet)
	bullet.transform = $Node2D/Marker2D.global_transform
	
	can_shoot = false
	var new_cooldown = max(
		INITIAL_FIRERATE - (shoot_hold_time * FIRERATE_DECREASE_RATE),
		MIN_FIRERATE
	)
	$ShootCooldown.wait_time = new_cooldown
	$ShootCooldown.start()

func _on_shoot_cooldown_timeout() -> void:
	can_shoot = true

func _on_area_entered(_area: Area2D) -> void:
	$HitAnimation.play("get_damaged")
