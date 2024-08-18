extends Node2D

#Variaveis da skill
var name_skill: String = "Sword"
var level_up_string: String = "Level_1"
var _level: int = 1
var _attack_damage: float = 10
var _attack_cooldown: float = 1.5
var _slash_duration: float = 0.5
var _size: float = 1
var enable: bool = false
var type = "Active"

#Variaveis de buff gerais
var cooldown_porc: float = 0

@onready var hero = Global.hero
@onready var position1 = $Positions/Pos1
@onready var position2 = $Positions/Pos2
@onready var sword_unit_scene = preload("res://scenes/weapons/sword_utils/sword_unit.tscn")
var sword1: Node2D
var sword2: Node2D

func _ready():
	sword1 = sword_unit_scene.instantiate()
	sword2 = sword_unit_scene.instantiate()
	sword1.position = position1.position
	sword2.position = position2.position
	sword2.number = 'second'
	add_child(sword1)
	add_child(sword2)
	update_stats()

func _process(delta):
	update_position()

func level_up():
	_level += 1
	level_up_string = "Level_" + str(_level+1)
	match _level:
		2:
			cooldown_porc += 0.1
			_attack_damage += 5
		3:
			_size += 0.1
			_attack_damage += 5
		4:
			_size += 0.1
		5:
			cooldown_porc += 0.1
			_attack_damage += 5
		6:
			_size += 0.1
			_attack_damage += 5
		7:
			_attack_damage += 5
	update_stats()

func update_position():
	sword1.position = hero.position + position1.position
	sword2.position = hero.position + position2.position

func update_stats():
	for sword in [sword1, sword2]:
		sword._damage = _attack_damage + (_attack_damage * Global.hero.buff_attack)
		sword._attack_cooldown = _attack_cooldown
		sword._level = _level
		sword._size = _size
		sword._slash_duration = _slash_duration
		sword.scale = Vector2(_size, _size)
