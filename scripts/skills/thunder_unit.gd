extends Area2D

@export_category('Variables')
@warning_ignore("unused_private_class_variable")
@export var _damage: int
var _target

var enemies = []

func _ready():
	if is_instance_valid(_target):
		$Sprite2D.global_position = _target.global_position
		global_position = _target.global_position
		$AnimationPlayer.play("default")

func damage():
	#is_queued_for_deletion isso aqui pode ser uma forma para ajeitar uma forma melhor kkk
	if is_instance_valid(_target):
		_target._update_health('damage', _damage)
