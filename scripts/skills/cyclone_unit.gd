extends Area2D

@export_category("Variabels")
@export var _damage: float
@export var _move_speed: float = 100
@export var _duration: float

var direction

func _ready():
	$DeleteTimer.start(_duration)

func _physics_process(delta):
	translate(direction * delta * _move_speed)

func _on_body_entered(body):
	if body is Enemy:
		body._update_health('damage', _damage)

func _on_delete_timer_timeout():
	queue_free()
