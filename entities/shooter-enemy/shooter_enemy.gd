extends Enemy

enum State { DROP_DOWN, CHARGE_ATTACK, ATTACK, LEAVE }

const SPEED = 300
const SHOOT_INTERVAL: float = 2.0 
const BULLET_PATH = preload("res://entities/bullet-enemy/bullet-enemy.tscn")

var curren_state: int
var target_drop_position: Vector2
var can_shoot: bool = true
var shoot_timer: float = SHOOT_INTERVAL
var leave_delay: float = randf_range(2.0,6.0)
var leave_timer: float = leave_delay

func _ready() -> void:
	super()
	$AnimatedSprite2D.play()
	target_drop_position = global_position + Vector2(0, 200)

func _init() -> void:
	health = 3
	curren_state = State.DROP_DOWN

func _physics_process(delta: float) -> void:
	match curren_state:
		State.DROP_DOWN:
			drop_down(delta)
		State.CHARGE_ATTACK:
			charge_attack(delta)
		State.ATTACK:
			attack(delta)
		State.LEAVE:
			leave(delta)

func drop_down(delta: float) -> void:
	if global_position.y < target_drop_position.y:
		position += Vector2(0, 1) * SPEED * delta
	else:
		curren_state = State.CHARGE_ATTACK

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
		curren_state = State.LEAVE
		
func attack(delta: float) -> void:
	leave_timer -= delta
	if leave_timer <= 0:  
		curren_state = State.LEAVE

func leave(delta: float) -> void:
	position += Vector2(0, -1) * SPEED * delta 


func shoot() -> void:
	var bullet_enemy = BULLET_PATH.instantiate()
	get_parent().add_child(bullet_enemy)
	bullet_enemy.global_position = global_position
	bullet_enemy.look_at(World.get_car_position())

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
