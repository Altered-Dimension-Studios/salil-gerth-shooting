extends ParallaxBackground


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Sky.motion_offset.x -= 5
	$Mountains.motion_offset.x -= 8
	$Road.motion_offset.x -= 15
