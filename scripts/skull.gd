extends Node2D

var level_up_string: String = "Level_1"
var _level: int = 1
var _attack_damage: float = 15
var _attack_cooldown: float = 4.0
var name_skill: String = "Skull"
var enable: bool = false
var type = "Active"

@onready var hero = Global.hero
@onready var skull_scene = preload("res://scenes/weapons/skulls_utils/skull_unit.tscn")
@onready var position1 = $Positions/Skull_1
@onready var position2 = $Positions/Skull_2
@onready var position3 = $Positions/Skull_3

var skull1: Node2D
var skull2: Node2D
var skull3: Node2D

func _ready():
	skull1 = skull_scene.instantiate()
	skull1.position = position1.position
	add_child(skull1)

func _process(delta):
	update_positions()
	
func level_up():
	_level += 1
	level_up_string = "Level_" + str(_level+1)
	match _level:
		2:
			_attack_cooldown -= 0.5
			_attack_damage += 5
		3:
			_attack_cooldown -= 0.5
			_attack_damage += 5
		4:
			skull1.queue_free()
			skull1 = null
			
			skull2 = skull_scene.instantiate()
			skull2.position = position2.position
			add_child(skull2)
			
			skull3 = skull_scene.instantiate()
			skull3.position = position3.position
			add_child(skull3)
		5:
			_attack_cooldown -= 0.5
			_attack_damage += 5
		6:
			_attack_cooldown -= 0.5
			_attack_damage += 5
		7:
			skull1 = skull_scene.instantiate()
			skull1.position = position1.position
			add_child(skull1)
	update_stats()

func update_stats():
	for i in [skull1, skull2, skull3]:
		if i:
			i._attack_cooldown = _attack_cooldown
			i._attack_damage = _attack_damage + (_attack_damage * Global.hero.buff_attack)

func update_positions():
	if skull1:
		skull1.position = hero.position + position1.position
	if skull2:
		skull2.position = hero.position + position2.position
	if skull3:
		skull3.position = hero.position + position3.position
