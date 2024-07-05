extends CharacterBody2D
@onready var _target
@onready var _velocity
@export var _enemy_type: String = 'normal'
@export var _move_speed: float = 170

func _physics_process(delta):
	if Global.hero:
		_target = Global.hero
		var _direction: Vector2 = global_position.direction_to(_target.global_position)
		match _enemy_type:
			'normal':
				normal(_direction)
			
		
		move_and_collide(_velocity * delta)



func normal(_direction: Vector2):
	_velocity = _direction * _move_speed
	
