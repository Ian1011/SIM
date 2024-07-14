extends CharacterBody2D
class_name Hero

@export_category('Variables')
@export var _level: int = 1
@export var _level_experience: int = 0
@export var _level_max_experience: int = 50
@export var _health: float = 100
@export var _speed: float = 90

var initial_skill = preload("res://scenes/weapons/skull.tscn")

@export_category('Objects')
@onready var camera = $Camera
@onready var control = $Control
@onready var sprite = $Sprite2D
@onready var attract_area = $AttractArea
@onready var collect_area = $CollectArea

var _health_max = _health
var health_initial = _health_max
var _look_direction = Vector2(0, 0)

# Funções Nativas
func _ready():
	Global.hero = self
	control.start_score()

func _physics_process(_delta):
	var _direction: Vector2 = Input.get_vector(
		'move_left', 'move_right',
		'move_up', 'move_down'
)
	if _direction != Vector2(0, 0):
		_look_direction = _direction
	if _direction.x < 0:
		sprite.flip_h = true
	elif _direction.x > 0:
		sprite.flip_h = false
	velocity = _direction * _speed
	
	_look_direction = velocity.normalized()
	camera.global_position = global_position
	move_and_slide()

# Funções
func add_skill(item):
	Global.game.upgrade_character(item)


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

#Level
func _update_level(_experience):
	_level_experience += _experience
	if _level_experience >= _level_max_experience:
		_level += 1
		_level_experience -= _level_max_experience
		update_experience_req()
		Global.game.skill_upgrade()
		control.update_level_count()

func update_experience_req():
	var exp_req = _level
	if _level < 21:
		exp_req = _level * 70
	elif _level < 42:
		exp_req = _level * 140
	else:
		exp_req = _level * 200
	_level_max_experience = exp_req
	

func _on_attract_area_area_entered(area):
	if area.is_in_group("loot"):
		area.target = self


func _on_collect_area_area_entered(area):
	if area.is_in_group("loot"):
		area.collect()
