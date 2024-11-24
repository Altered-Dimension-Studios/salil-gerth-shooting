extends Enemy
enum State { CHARGE_ATTACK, ATTACK }
# Note: Speed and Fire Rate can grow based on health?
var SPEED = 300
var SHOOT_INTERVAL: float = 0.75 
const BULLET_PATH = preload("res://entities/bullet-enemy/bullet-enemy.tscn")

var curren_state: int
var target_drop_position: Vector2
var can_shoot: bool = true
var shoot_timer: float = SHOOT_INTERVAL
var leave_delay: float = randf_range(2.0,6.0)
var leave_timer: float = leave_delay
var speed = 300.0 
var fire_rate = 0.5
var facing_right = false

# TODO: Add Attack and Health Bar
func _init() -> void:
	health = 1
	curren_state = State.CHARGE_ATTACK

func _ready():
	position.x = Settings.screen_size.y / 2
	position.y = Settings.screen_size.x / 8
	$AnimatedSprite2D.play()
	
func _physics_process(delta: float) -> void:
	if facing_right:
		speed = (300 + 5*(100 - health))  *-1
	elif !facing_right:
		speed = (300 + 5*(100 - health)) 
	SHOOT_INTERVAL = float(health)/100.0 + 0.3
	match curren_state:
		State.CHARGE_ATTACK:
			charge_attack(delta)
		State.ATTACK:
			attack(delta)
			
func _process(delta):	
	position.x += speed * delta
	
func charge_attack(delta: float) -> void:
	if can_shoot:
		shoot()
		can_shoot = false
		shoot_timer = SHOOT_INTERVAL
	else:
		shoot_timer -= delta
		if shoot_timer <= 0:
			can_shoot = true
	leave_timer -= delta
	if leave_timer <= 0:  
		curren_state = State.ATTACK
		
func attack(delta: float) -> void:
	leave_timer -= delta
	if leave_timer <= 0:  
		curren_state = State.CHARGE_ATTACK
# Flip when reaching the border

func shoot() -> void:
	var bullet_enemy = BULLET_PATH.instantiate()
	get_parent().add_child(bullet_enemy)
	bullet_enemy.global_position = global_position
	bullet_enemy.look_at(World.get_car_position())
	
func flip():
	if facing_right:
		speed = abs(speed)
	else:
		speed = abs(speed) * -1
	scale.x = (scale.x) * -1
	facing_right = !facing_right
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	flip()
