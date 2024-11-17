extends Area2D

const SPEED = 750

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _physics_process(delta):
	position += transform.x * SPEED * delta


func _on_area_entered(area: Area2D) -> void:
	queue_free()
