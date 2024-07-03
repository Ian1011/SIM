extends Node2D

@onready var positions = $Hero/Positions
@onready var timer = $TimerSpawn
@onready var player = $Hero



var enemy_scene = preload("res://scenes/ghost.tscn")


func spawn_enemy():
	var player_position = player.position
	
	var positions_list = positions.get_children()
	var spawn_position = positions_list.pick_random()
	var enemy_instance = enemy_scene.instantiate()

	var new_position = player_position + spawn_position.position

	enemy_instance.global_position = new_position
	print("player position: ", player_position)
	print("spawn position: ", spawn_position.position)
	print("new position: ", new_position)
	add_child(enemy_instance)
	print("Inimigo spawnado")
	




func _on_timer_spawn_timeout():
	spawn_enemy()
