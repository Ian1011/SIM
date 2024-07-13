extends Area2D

@export_category('Variables')
@export var amount_hp: int = 20

@onready var anim = $AnimationPlayer
@onready var collision = $CollisionShape2D

var speed = -2
var target = null

func _process(delta):
	if target != null:
		global_position = global_position.move_toward(target.global_position, speed)
		speed += 4*delta
		anim.play("collect")
		

func collect():
	target._update_health('heal', amount_hp)
	collision.call_deferred("set","disabled",true)
	queue_free()
