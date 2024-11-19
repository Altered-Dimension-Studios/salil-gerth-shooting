extends Node2D

const CAR = preload("res://entities/car/car.tscn")
var player_car: Car

func _init() -> void:
	start_game()


func start_game() -> void:
	spawn_player_car()


func spawn_player_car() -> void:
	player_car = CAR.instantiate()
	add_child(player_car)


func get_car_position():
	return player_car.global_position
