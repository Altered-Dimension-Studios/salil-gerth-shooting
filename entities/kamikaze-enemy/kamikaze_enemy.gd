extends Enemy

enum State {DROP_DOWN, CHARGE_ATTACK, ATTACK}
const SPEED = 300
var curren_state: int
var path_to_player_car: Vector2
var timer: float


func _init() -> void:
	health = 3
	curren_state = State.DROP_DOWN
	timer = 0.7


func _physics_process(delta: float) -> void:
	match curren_state:
		State.DROP_DOWN:
			drop_down(delta)
		State.CHARGE_ATTACK:
			charge_attack(delta)
		State.ATTACK:
			attack(delta)


func charge_attack(delta) -> void:
	position += (path_to_player_car * SPEED * delta) * -1
	if timer >= 0:
		timer -= delta
	else:
		curren_state = State.ATTACK
	

func attack(delta: float) -> void:
	position += path_to_player_car * SPEED * delta


func drop_down(delta: float) -> void:
	position += Vector2(0, 1) * SPEED * 1.25 * delta
	if timer >= 0:
		timer -= delta
	else:
		path_to_player_car = (World.get_car_position() - global_position).normalized()
		curren_state = State.CHARGE_ATTACK
		timer = 0.2


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
