extends Node2D

#Carac
var name_skill: String = ""
var level_up_string: String = "Level_1"

@export_category('Variables')
@warning_ignore("unused_private_class_variable")
@export var _level: int = 0
@export var _attack_damage: int = 10
@export var _attack_cooldown: float = 3.0
@export var _target: Node2D

@export_category('Objects')
@export var _attack_timer: Timer
@export var _detection_area: Area2D
#@export var _attack_area: Area2D
@export var _animation: AnimationPlayer

var is_attacking: bool = false
var projectile = preload("res://management/projectile_template.tscn")

#Funções
func _spawn_projetctile() -> void:
	if is_instance_valid(_target):
		var _direction: Vector2 = global_position.direction_to(_target.global_position)
		var projectile_instance = projectile.instantiate()
		projectile_instance.global_position = global_position
		projectile_instance.direction = _direction
		get_tree().root.call_deferred('add_child', projectile_instance)

func level_up():
	_level += 1
	level_up_string = "Level_" + str(_level+1)
	match _level:
		2:
			pass
		3:
			pass
		4:
			pass
		5:
			pass
		6:
			pass
		7:
			pass

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
	
