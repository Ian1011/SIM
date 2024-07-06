extends CharacterBody2D
class_name Hero

@export_category('Variables')
@export var _level: int = 1
@export var _level_experience: int = 0
@export var _level_max_experience: int = 100
@export var _health: float = 100
@export var _speed: float = 125

@export_category('Objects')
@onready var camera = $Camera
@onready var control = $Control

@export_category('skull')
@onready var skull_scene = preload("res://scenes/weapons/skull.tscn")
@onready var positions = $SkullPosition
@onready var positions_list = positions.get_children()
@onready var skull_instance1 = skull_scene.instantiate()
@onready var skull_instance2 = skull_scene.instantiate()
@onready var skull_instance3 = skull_scene.instantiate()
@onready var skull_instance4 = skull_scene.instantiate()

var _health_max = _health

# Funções Nativas
func _ready():
	Global.hero = self
	spawn_skull()
	control.start_score()

func _physics_process(_delta):
	var _direction: Vector2 = Input.get_vector(
		'move_left', 'move_right',
		'move_up', 'move_down'
)
	
	velocity = _direction * _speed
	
	camera.global_position = global_position
	move_and_slide()

# Funções
func spawn_skull():
	skull_instance1.global_position = positions_list[0].global_position
	skull_instance2.global_position = positions_list[1].global_position
	skull_instance3.global_position = positions_list[2].global_position
	skull_instance4.global_position = positions_list[3].global_position
	add_child(skull_instance1)
	add_child(skull_instance2)
	add_child(skull_instance3)
	add_child(skull_instance4)

#Health
func _update_health(_damage: String, _points: int):
	match _damage:
		"damage":
			_health -= _points
			if _health <= 0:
				Global.game_over()

		"heal":
			_health += _points
			if _health > _health_max:
				_health = _health_max

	control._update_health_counter()

func _update_level(_experience):
	_level_experience += _experience
	if _level_experience >= _level_max_experience:
		_level += 1
		_level_experience = 0
		_level_max_experience += _level_max_experience / 2
		control.update_level_count()

