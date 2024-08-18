extends Node2D

var level_up_string: String = "Level_1"
var name_skill: String = "Cyclone"
var enable: bool = false
var type = "Active"

@export_category('Variables')
@warning_ignore("unused_private_class_variable")
@export var _level: int = 1
@export var _attack_damage: float = 15
@export var _attack_cooldown: float = 5.0
@export var _cooldown_porc: float = 0
@export var _duration: float = 2.0
@export var _num_projectiles: int = 1

var projectile_scene = preload("res://scenes/weapons/cyclone/cyclone_unit.tscn")

@onready var attack_timer = $AttackTimer

func _ready():
	attack_timer.start(_attack_cooldown * (1 - _cooldown_porc))

func _process(delta):
	update_position()

func spawn_projectile(direction):
	var projectile_instance = projectile_scene.instantiate()
	projectile_instance.global_position = global_position
	projectile_instance.direction = direction
	projectile_instance._duration = _duration
	projectile_instance._damage = _attack_damage + (_attack_damage * Global.hero.buff_attack)
	get_tree().root.call_deferred('add_child', projectile_instance)

func attack():
	for i in range(_num_projectiles):
		var direction = Vector2(randf_range(-1, 1), randf_range(-1, 1))
		#var last_direction -- Isso aqui é uma próxima feature para melhorar a posição de cada ciclone, para não ter tão repetido
		spawn_projectile(direction)
	attack_timer.start(_attack_cooldown * (1 - _cooldown_porc))

func update_position():
	global_position = Global.hero.global_position

func level_up():
	_level += 1
	level_up_string = "Level_" + str(_level+1)
	match _level:
		2:
			_attack_damage += 5
			_num_projectiles += 1
		3:
			_cooldown_porc += 0.10
			_num_projectiles += 1
		4:
			_attack_damage += 5
			_duration += (_duration * 0.25)
		5:
			_attack_damage += 5
			_num_projectiles += 1
		6:
			_attack_damage += 5
			_num_projectiles += 1
		7:
			_cooldown_porc += 0.10
			_duration += (_duration * 0.25)

func _on_attack_timer_timeout():
	attack()
