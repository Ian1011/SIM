extends Node2D

@onready var positions = $Hero/Positions
@onready var timer = $TimerSpawn
@onready var player = $Hero
@onready var theme1 = $Theme

var difficulty_tax: float = 0
var enemy_scenes = [preload("res://scenes/enemies/ghost.tscn"), preload("res://scenes/enemies/howl.tscn")]

# Funções Nativas
func _ready():
	pass

#Funções
func spawn_enemy():
	difficulty_calc()
	for i in range(difficulty_tax + 2):
		var player_position = player.position
		var positions_list = positions.get_children()
		var spawn_position = positions_list.pick_random()
		var enemy_instance = enemy_scenes.pick_random()
		enemy_instance = enemy_instance.instantiate()
		var new_position = player_position + spawn_position.position
		enemy_instance.global_position = new_position
		add_child(enemy_instance)

func difficulty_calc():
	difficulty_tax = (player.control.minutes / 10) * 1
	Global.difficulty_tax = difficulty_tax

func _on_audio_stream_player_finished():
	theme1.play()

func _on_timer_spawn_timeout():
		spawn_enemy()
