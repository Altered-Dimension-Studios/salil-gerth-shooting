extends Enemy

enum State { DROP_DOWN, ATTACK }

const SPEED = 700
var path_to_player_car = Vector2.ZERO  
var curren_state: int
var timer: float

func _ready() -> void:
	super()
	$AnimatedSprite2D.play()
	health = 1
	curren_state = State.DROP_DOWN
	timer = 0.1

func _physics_process(delta: float) -> void:
	match curren_state:
		State.DROP_DOWN:
			drop_down(delta)
		State.ATTACK:
			attack(delta)

func drop_down(delta: float) -> void:
	position += Vector2(0, 1) * SPEED * 1.25 * delta  
	if timer > 0:
		timer -= delta
	else:
		
		path_to_player_car = (World.get_car_position() - global_position).normalized()
		curren_state = State.ATTACK
		timer = randf_range(0, 2) 

func attack(delta: float) -> void:
	position += path_to_player_car * SPEED * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_explode_sprite_animation_finished() -> void:
	queue_free()
