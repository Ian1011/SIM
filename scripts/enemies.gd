extends Node2D

var spawns = [{
	'scene':preload("res://scenes/enemies/howl.tscn"),
	'timer':0.0,
	'interval':1.5,
	'start':0.5*60,
	'end':5.0*60
},{
	'scene':preload("res://scenes/enemies/ghost.tscn"),
	'timer':0.0,
	'interval':1.0,
	'start':0.0,
	'end':10.0*60
},{
	'scene':preload("res://scenes/enemies/flame.tscn"),
	'timer':0.0,
	'interval':10.0,
	'start':1*60,
	'end':20*60
}]

var game_time


func _ready():
	pass

func _process(delta):
	game_time = Global.game.game_time
	
	for spawn in spawns:
		if game_time >= spawn.start and game_time <= spawn.end:
			spawn.timer += delta

			while spawn.timer >= spawn.interval:
				spawn.timer -= spawn.interval
				var enemy_instance = spawn.scene.instantiate()
				var spawn_position = Global.game.positions_list.pick_random()
				var new_position = Global.hero.global_position + spawn_position.position
				enemy_instance.position = new_position
				add_child(enemy_instance)
				
		elif game_time >= spawn.end:
			spawns.erase(spawn)
