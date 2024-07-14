extends Node2D

@export_category('Variables')
@export var _damage: float
@export var _attack_duration: float = 0.5
@export var move_speed: float = 300

@onready var _attack_timer = $AttackTimer
@onready var sprite = $Sprite2D

var _direction = Vector2(1,0)

func _ready():
	_attack_timer.start(_attack_duration)
	if rotation == 180:
		sprite.flip_h = false
		sprite.flip_v = false


func _process(delta):
	move_speed += delta*5
	translate(_direction * delta * move_speed)

#Funções de Sinal
func _on_detection_area_body_entered(_body):
	if _body is Enemy:
		_body._update_health('damage', _damage)

func _on_attack_timer_timeout():
	queue_free()
