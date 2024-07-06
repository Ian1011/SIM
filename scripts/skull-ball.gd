extends Area2D

@export_category("Variabels")
@export var _damage: int = 10
@export var _move_speed: float = 300
@export var _level: int = 1

@export_category('Objects')
@export var _timer_delete: Timer

var direction: Vector2
var is_delete: bool = false

#Funções nativas
func _ready():
	rotation = direction.angle()
	update_stats()
	
func _physics_process(delta):
	translate(direction * delta * _move_speed)

#Funções
func update_stats():
	if Global.hero._level % 2 == 0:
		_level = Global.hero._level / 2

	elif Global.hero._level != 1:
		_level = Global.hero._level - 1
	_damage = _damage + ((_damage * _level) /2)

#Funções de Sinal
func _on_area_2d_body_entered(body):
	if body is Enemy:
		body._update_health('damage', _damage)
		queue_free()

func _on_timer_delete_timeout():
	if is_delete:
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	is_delete = true
	_timer_delete.start()
