extends Node2D

@export_category('Variables')
@export var _damage: float
@export var _atack_duration: float = 0.5
@export var _target: Node2D
@export var _size: float

@export_category('Objects')
@export var _attack_timer: Timer
@export var _detection_area: Area2D

func _ready():
	_attack_timer.start(_atack_duration)

#Funções de Sinal
func _on_detection_area_body_entered(_body):
	if _body is Enemy:
		_body._update_health('damage', _damage)

func _on_attack_timer_timeout():
	queue_free()
