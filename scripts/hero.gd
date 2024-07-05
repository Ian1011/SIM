extends CharacterBody2D
class_name Hero

var _health_max
var _life_bar_sprites = {}
var minutes = 0
var seconds = 0

@export_category('Variables')
@export var _level: int = 1
@export var _health: float = 100
@export var _speed: float = 150

@onready var life_bar_sprite = $LifeBar
@onready var life_bar_num = $Hp
@onready var clock_timer = $ClockTimer

@export_category('Objects')
@onready var camera = $Camera
@onready var lifebar = $LifeBar

@export_category('skull')
@onready var skull_scene = preload("res://scenes/weapons/skull.tscn")
@onready var positions = $SkullPosition
@onready var positions_list = positions.get_children()
@onready var skull_instance1 = skull_scene.instantiate()
@onready var skull_instance2 = skull_scene.instantiate()
@onready var skull_instance3 = skull_scene.instantiate()
@onready var skull_instance4 = skull_scene.instantiate()

func _ready():
	preload_resources()
	Global.hero = self
	_health_max = _health
	_update_parameters()
	spawn_skull()
	

func _physics_process(_delta):
	var _direction: Vector2 = Input.get_vector(
		'move_left', 'move_right',
		'move_up', 'move_down'
)
	
	velocity = _direction * _speed
	
	camera.global_position = global_position
	move_and_slide()
	

func preload_resources():
	_life_bar_sprites = {
		"100%":preload("res://sprites/lifebar/lifebar1.png"),
		"80%":preload("res://sprites/lifebar/lifebar2.png"),
		"60%":preload("res://sprites/lifebar/lifebar3.png"),
		"40%":preload("res://sprites/lifebar/lifebar4.png"),
		"20%":preload("res://sprites/lifebar/lifebar5.png"),
		"0%":preload("res://sprites/lifebar/lifebar6.png")
	}

func spawn_skull():
	skull_instance1.global_position = positions_list[0].global_position
	skull_instance2.global_position = positions_list[1].global_position
	skull_instance3.global_position = positions_list[2].global_position
	skull_instance4.global_position = positions_list[3].global_position
	add_child(skull_instance1)
	add_child(skull_instance2)
	add_child(skull_instance3)
	add_child(skull_instance4)

func _update_health(_damage: String, _points: int):
	match _damage:
		"damage":
			_health -= _points
			if _health <= 0:
				pass#queue_free()

		"heal":
			_health += _points
			if _health > _health_max:
				_health = _health_max

	_update_parameters()
	

func _update_parameters():
	life_bar_num.text = str(_health, "/", _health_max)
	var life_bar_porc: float = _health / _health_max
	print (life_bar_porc)
	if life_bar_porc > 0.80:
		_update_life_bar("100%")
	elif life_bar_porc > 0.60:
		_update_life_bar('80%')
	elif life_bar_porc > 0.40:
		_update_life_bar('60%')
	elif life_bar_porc > 0.20:
		_update_life_bar('40%')
	elif life_bar_porc >= 0.00001:
		_update_life_bar('20%')
	else:
		_update_life_bar('0%')
		

func _update_life_bar(key):
	lifebar.texture = _life_bar_sprites[str(key)]
