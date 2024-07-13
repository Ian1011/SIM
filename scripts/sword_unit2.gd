extends Node2D

@export_category('Variables')
@export var _damage: float
@export var _atack_duration: float = 1.0
@export var _target: Node2D
@export var _size: float
@export var move_speed: int = 500

@export_category('Objects')
@export var _attack_timer: Timer
@export var _detection_area: Area2D


var direction: Vector2
var _rotation = 0

func _ready():
	_attack_timer.start(_atack_duration)
	rotation = _rotation

func _process(delta):
	move_speed += delta*5
	translate(direction * delta * move_speed)

#Funções de Sinal
func _on_detection_area_body_entered(_body):
	if _body is Enemy:
		_body._update_health('damage', _damage)

func _on_attack_timer_timeout():
	queue_free()
