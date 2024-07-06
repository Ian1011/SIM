extends CharacterBody2D
class_name Enemy
@onready var _target
@onready var _velocity
var is_attacking = false

@export_category('Variables')
@export var _enemy_type: String = 'normal'
@export var _health_points: int = 20
@export var _damage: int = 10
@export var _invencibility_cooldown: float = 0.5
@export var _experience: int = 10
@export var _move_speed: float = 100

@export_category('Objects')
@export var _invencibility_timer: Timer
@export var _timer_delete: Timer
@export var _hitbox_area: Area2D

var is_delete: bool = false

# Funções do sistema
func _ready():
	if _enemy_type == 'line':
		if Global.hero:
			_target = Global.hero
			line()
	_update_stats(Global.difficulty_tax)

func _physics_process(delta):
	if Global.hero:
		_target = Global.hero
		var _direction: Vector2 = global_position.direction_to(_target.global_position)
		match _enemy_type:
			'normal':
				normal(_direction)
		
		move_and_collide(_velocity * delta)

# Funções de padrão de movimento
func normal(_direction: Vector2):
	_velocity = _direction * _move_speed
	
func line():
	var _direction_line: Vector2 = global_position.direction_to(_target.global_position)
	_velocity = _direction_line * _move_speed
	
# Funções diversas
func _update_health(damage, points):
	match damage:
		"damage":
			self._health_points -= points
			if self._health_points <= 0:
				Global.hero._update_level(_experience)
				queue_free()

func _update_stats(tax):
	_health_points = _health_points + (_health_points * tax)
	_damage = _damage + (_damage * tax)
	_experience = _experience + (_experience * tax)

func _on_timer_delete_timeout():
	if is_delete:
		queue_free()

func _on_hitbox_area_body_entered(body):
	if body is Hero:
		_hitbox_area.set_deferred("monitoring", false)
		_invencibility_timer.start(_invencibility_cooldown)
		body._update_health("damage", _damage)

func _on_invencibility_timer_timeout():
	_hitbox_area.set_deferred("monitoring", true)


func _on_visible_on_screen_screen_exited():
	is_delete = true
	_timer_delete.start()
