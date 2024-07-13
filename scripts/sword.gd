extends Node2D

#Variaveis da skill
var name_skill: String = "Sword"
var level_up_string: String = "Level_1"
var _level: int = 1
var _attack_damage: float = 10
var _attack_cooldown: float = 1.5
var _size: float = 0
var _hits: int = 1
var enable: bool = false

#Variaveis de buff gerais
var cooldown_porc: float = 0

@onready var hero = Global.hero
@onready var slash_scene = preload("res://scenes/weapons/sword_utils/sword_unit.tscn")
@onready var position1 = $Positions/Pos1
@onready var cooldown = $Cooldown
var slash: Node2D
var relative_position = Vector2(0, 0)
var relative_direction = Vector2(0, 0)

func _ready():
	cooldown.start(_attack_cooldown)
	relative_direction = position1.position.normalized()

func _process(delta):
	update_position()

func level_up():
	for i in range(6):
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
				_hits += 1

func update_position():
	relative_position = hero.position + position1.position
	if hero._look_direction.x != 0:
		relative_direction = hero._look_direction
	#relative_position = hero.position + position1.position * relative_direction

func _on_cooldown_timeout():
	for i in range(_hits):
		slash = slash_scene.instantiate()
		slash.scale += Vector2(_size, _size)
		slash._damage = _attack_damage
		if relative_direction.x >= 0:
			slash.position = relative_position
		elif relative_direction.x <= 0:
			slash.position = relative_position - position1.position * 2
		#slash.position = relative_position
		slash.direction = Vector2(relative_direction.x, 0)
		if slash.direction.x == -1:
			slash._rotation = 180 
		add_child(slash)
	cooldown.start(_attack_cooldown - (_attack_cooldown * 0.1))
