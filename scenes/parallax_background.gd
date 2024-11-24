extends ParallaxBackground


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Sky.motion_offset.x -= .05
	$"Foreground Far".motion_offset.x -= .1
	$"Foreground Medium".motion_offset.x -= .2
	$"Foreground Near".motion_offset.x -= .5
	$"Road".motion_offset.x -= 10
	$"Lamps".motion_offset.x -= 10
