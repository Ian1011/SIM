extends Area2D
class_name Projectile

@export_category("Variabels")
@export var _damage: float = 10
@export var _move_speed: float = 300
var direction: Vector2

func _ready():
	rotation = direction.angle()

func _physics_process(delta):
	translate(direction * delta * _move_speed)

func _on_area_2d_body_entered(body):
	if body is Enemy:
		print("Alvo abatido")
		body._update_health('damage', _damage)
		queue_free()
