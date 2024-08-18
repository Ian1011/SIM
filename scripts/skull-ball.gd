extends Area2D

@export_category("Variabels")
@export var _damage: float
@export var _move_speed: float = 300


@export_category('Objects')
@export var _timer_delete: Timer

@onready var explosion_sprite = $AttackArea/SpriteExplosion
@onready var explosion_sprite2 = $AttackArea/SpriteExplosion2
@onready var skull_ball_sprite = $AnimatedSprite2D
@onready var anim = $AttackArea/AnimationPlayer

var direction: Vector2
var is_delete: bool = false
var is_attacking: bool = false
var enemies = []

#Funções nativas
func _ready():
	explosion_sprite.visible = false
	explosion_sprite2.visible = false
	rotation = direction.angle()

func _physics_process(delta):
	translate(direction * delta * _move_speed)

#Funções de Sinal
func _on_visible_on_screen_notifier_2d_screen_exited():
	is_delete = true
	_timer_delete.start()

func _on_timer_delete_timeout():
	if is_delete:
		queue_free()

func _on_body_entered(body):
	if body is Enemy:
		_move_speed = 0
		set_deferred("monitoring", false)
		skull_ball_sprite.visible = false
		anim.play("explosion")
		damage_area()


func _on_attack_area_body_entered(body):
	if body is Enemy:
			enemies.append(body)


func _on_attack_area_body_exited(body):
	if body in enemies:
		enemies.erase(body)

func damage_area():
	for body in enemies:
		body._update_health('damage', _damage)
