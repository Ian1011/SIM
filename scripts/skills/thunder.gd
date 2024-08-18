extends Node2D

@export_category('Variables')
@warning_ignore("unused_private_class_variable")
@export var _level: int = 1
@export var _attack_damage: float = 20
@export var _attack_cooldown: float = 4.0
@export var _cooldown_porc: float = 0
@export var _num_projectiles: int = 1

var name_skill: String = "Thunder"
var enable: bool = false
var type = "Active"
var level_up_string: String = "Level_1"
var enemies = []
var in_cooldown = false

@export_category('Objects')
@export var _attack_timer: Timer

var projectile_scene = preload("res://scenes/weapons/thunder/thunder_unit.tscn")

func _ready():
	_attack_timer.start(_attack_cooldown * (1 - _cooldown_porc))

func _process(delta):
	update_position()

func attack():
	for i in range(_num_projectiles):
		spawn_projectile()
	in_cooldown = true
	_attack_timer.start(_attack_cooldown * (1 - _cooldown_porc))

func spawn_projectile():
	if enemies:
		var _target = enemies.pick_random()
		var projectile_instance

		if is_instance_valid(_target):
			projectile_instance = projectile_scene.instantiate()
			projectile_instance._damage = _attack_damage + (_attack_damage * Global.hero.buff_attack)
			projectile_instance._target = _target
			get_tree().root.call_deferred('add_child', projectile_instance)

func level_up():
	_level += 1
	level_up_string = "Level_" + str(_level+1)
	match _level:
		2:
			_attack_damage += 5
			_num_projectiles += 1
		3:
			_attack_damage += 5
			_num_projectiles += 1
		4:
			_cooldown_porc += 0.1
		5:
			_attack_damage += 5
			_num_projectiles += 1
		6:
			_attack_damage += 5
			_num_projectiles += 1
		7:
			_cooldown_porc += 0.1

func update_position():
	global_position = Global.hero.global_position

func _on_detection_area_body_entered(body):
	if body is Enemy:
		enemies.append(body)

func _on_detection_area_body_exited(body):
	if body in enemies:
		enemies.erase(body)

func _on_attack_timer_timeout():
	in_cooldown = false
	attack()
