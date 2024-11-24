extends Enemy


# Note: Speed and Fire Rate can grow based on health?
var speed = 300.0 
var fire_rate = 0.5
var facing_right = false

# TODO: Add Attack and Health Bar
func _init() -> void:
	health = 100

func _ready():
	position.x = Settings.screen_size.y / 2
	position.y = Settings.screen_size.x / 8
	$AnimatedSprite2D.play()

func _process(delta):
	position.x += speed * delta
	
# Flip when reaching the border
func flip():
	if facing_right:
		speed = abs(speed)
	else:
		speed = abs(speed) * -1
	scale.x = (scale.x) * -1
	facing_right = !facing_right
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	flip()
