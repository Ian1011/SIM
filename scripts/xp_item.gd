extends Area2D
class_name Loot

@export_category('Variables')
@export var experience: int = 10

@onready var sprite_red
@onready var sprite_green

@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var anim = $AnimationPlayer

var target = null
var speed = -2

func _ready():
	if experience > 50:
		pass
		#sprite.texture = sprite_green
	else:
		pass
		#sprite.texture = sprite_red

func _physics_process(delta):
	if target != null:
		global_position = global_position.move_toward(target.global_position, speed)
		anim.play("collect")
		speed += 4*delta
		
func collect():
	if target is Hero:
		target._update_level(experience)
		collision.call_deferred("set","disabled",true)
		queue_free()

