extends Node2D

@export_category('Variables')
@export var _damage: float
@export var _attack_cooldown: float = 1.5
@export var _level: int = 1
@export var _size: float
@export var _slash_duration: float = 0.5

@export_category('Objects')
@export var sprite: Sprite2D
@export var collision: CollisionShape2D
@export var anim: AnimationPlayer
@export var cooldown: Timer

@onready var hero = Global.hero
@onready var slash_scene = preload("res://scenes/weapons/sword_utils/sword_slash.tscn")
@onready var skill_base = get_tree().get_first_node_in_group("skill")

var cooldown_porc: float = 0.0 
var number: String = "first"
var animation: String = 'attack'
var position_number = Vector2(40,0)

func _ready():
	visible = true
	cooldown.start(_attack_cooldown * (1 - cooldown_porc))
	set_deferred("monitoring", false)
	if number == "second":
		sprite.flip_h = true
		sprite.rotation = 45
		animation = 'attack2'
		position_number = Vector2(-40,0)
		
func attack():
	anim.play(animation)

func summon_slash():
	if _level >= 7:
		var slash = slash_scene.instantiate()
		slash.scale = Vector2(_size, _size)
		slash._damage = _damage
		slash._attack_duration = _slash_duration
		if number == 'first':
			slash.position = position + Vector2(150, 0)
			slash._direction = Vector2(1,0)
		elif number == 'second':
			slash.rotation = 180
			slash.position = position + Vector2(-150, 0)
			slash._direction = Vector2(-1,0)
		skill_base.call_deferred("add_child", slash)


func _on_body_entered(body):
	if body is Enemy:
		body._update_health('damage', _damage)

func _on_cooldown_timeout():
	attack()

func _on_animation_player_animation_finished():
	cooldown.start(_attack_cooldown * (1 - cooldown_porc))
