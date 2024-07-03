extends CharacterBody2D
@onready var target

@export var speed = 140

func _physics_process(delta):
	if target:
		var direction = (target.global_position - global_position).normalized()
		move_and_collide(direction * delta * 140)


func _on_area_2d_body_entered(body):
	if body.is_in_group('Hero'):
		target = body
