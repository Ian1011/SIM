extends Area2D

@export_category("Variabels")
@export var _damage: float
@export var _move_speed: float = 300
@export var _duration: float = 0.2
@export var _attack_cooldown: float = 0.5


@export_category('Objects')
@export var _timer_delete: Timer
@export var _attack_timer: Timer
@export var _attack_area: Area2D

@onready var explosion_sprite = $AttackArea/SpriteExplosion
@onready var skull_ball_sprite = $AnimatedSprite2D

var direction: Vector2
var is_delete: bool = false
var is_attacking: bool = false
var enemies = []

#Funções nativas
func _ready():
	explosion_sprite.visible = false
	_attack_area.set_deferred('monitoring', false)
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
		explosion_sprite.visible = true
		_attack_timer.start(_duration)
		_attack_area.set_deferred('monitoring', true)


func _on_attack_area_body_entered(body):
	if body is Enemy:
			enemies.append(body)


func _on_attack_area_body_exited(body):
	if body is Enemy:
		enemies.erase(body)


func _on_attack_timer_timeout():
	for body in enemies:
		body._update_health('damage', _damage)
	queue_free()


