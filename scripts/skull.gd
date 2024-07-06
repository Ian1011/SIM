extends Node2D

@export_category('Variables')
@warning_ignore("unused_private_class_variable")
@export var _level: int = 1
#@export var _attack_damage: int
@export var _attack_cooldown: float = 1.5
@export var _target: Node2D

@export_category('Objects')
@export var _attack_timer: Timer
@export var _detection_area: Area2D
#@export var _attack_area: Area2D
@export var _animation: AnimationPlayer

var is_attacking: bool = false
var projectile = preload("res://scenes/weapons/skull-ball.tscn")

#Funções
func _spawn_projetctile() -> void:
	if is_instance_valid(_target):
		var _direction: Vector2 = global_position.direction_to(_target.global_position)
		var projectile_instance = projectile.instantiate()
		projectile_instance.global_position = global_position
		projectile_instance.direction = _direction
		get_tree().root.call_deferred('add_child', projectile_instance)

#Funções de Sinal
func _on_detection_area_body_entered(_body):
	if is_attacking:
		return

	if _body is Enemy:
		_target = _body
		_detection_area.set_deferred('monitoring', false)
		_attack_timer.start(_attack_cooldown)
		is_attacking = true
		_animation.play('attacking')

func _on_attack_timer_timeout():
	_detection_area.set_deferred('monitoring', true)
	is_attacking = false
	

