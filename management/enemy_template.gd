extends CharacterBody2D
class_name Enemy
@onready var _target
@onready var _velocity
@onready var sprite = $Texture
@onready var loot_base = get_tree().get_first_node_in_group("loot")
@onready var enemies_base = get_tree().get_first_node_in_group("enemies")
@onready var xp_item = preload("res://scenes/items/xp_item.tscn")
@onready var hp_item = preload("res://scenes/items/hp_item.tscn")
var is_attacking = false

@export_category('Variables')
@export var _enemy_type: String = 'normal'
@export var _health_points: int = 20
@export var _damage: int = 10
@export var _invencibility_cooldown: float = 0.5
@export var _experience: int = 10
@export var _move_speed: float = 60
@export var is_delete: bool = false

@export_category('Objects')
@export var _invencibility_timer: Timer
@export var _timer_delete: Timer
@export var _hitbox_area: Area2D


# Funções do sistema
func _ready():
	if Global.hero:
		_target = Global.hero
	if _enemy_type == 'line':
			line()

func _physics_process(delta):
		var _direction: Vector2 = global_position.direction_to(_target.global_position)
		match _enemy_type:
			'normal':
				normal(_direction)
			'flame':
				flame(_direction)
		if _enemy_type != 'line':
			if _direction.x < 0:
				sprite.flip_h = true
			elif _direction.x > 0:
				sprite.flip_h = false
		move_and_collide(_velocity * delta)

# Funções de padrão de movimento
func normal(_direction: Vector2):
	_velocity = _direction * _move_speed
	
func flame(_direction: Vector2):
	_velocity = _direction * _move_speed
	
func line():
	var _direction_line: Vector2 = global_position.direction_to(_target.global_position)
	if _direction_line.x < 0:
		sprite.flip_h = true
	elif _direction_line.x > 0:
		sprite.flip_h = false
	_velocity = _direction_line * _move_speed
	
# Funções diversas
func _update_health(damage, points):
	match damage:
		"damage":
			self._health_points -= points
			if self._health_points <= 0:
				death()

func death():
	if _enemy_type == 'flame':
		var flame_minion = preload("res://scenes/enemies/flame_minion.tscn")
		var positions = [Vector2(15, 0), Vector2(-15, 0), Vector2(0, -20)]
		for i in range(3):
			var flame_minion_instance = flame_minion.instantiate()
			flame_minion_instance.global_position = global_position + positions[i]
			enemies_base.call_deferred("add_child", flame_minion_instance)
	var item_instance = xp_item.instantiate()
	item_instance.experience = _experience
	item_instance.global_position = global_position
	loot_base.call_deferred("add_child", item_instance)
	queue_free()

func _on_timer_delete_timeout():
	queue_free()

func _on_hitbox_area_body_entered(body):
	if body is Hero:
		_hitbox_area.set_deferred("monitoring", false)
		_invencibility_timer.start(_invencibility_cooldown)
		body._update_health("damage", _damage)

func _on_invencibility_timer_timeout():
	_hitbox_area.set_deferred("monitoring", true)

func _on_visible_on_screen_screen_exited():
	if is_delete:
		_timer_delete.start()
