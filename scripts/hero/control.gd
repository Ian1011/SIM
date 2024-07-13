extends Control

@export var default_minutes := 0
@export_range(0, 59) var default_seconds := 0

@onready var timer_counter = $TimerCounter
@onready var life_bar_num = $Hp
@onready var life_bar = $Control/LifeBar
@onready var level = $Level

var _hero = Global.hero
var _life_bar_sprites = {}
var minutes = 0
var seconds = 0



func _ready():
	var viewport_size = get_viewport().size
	# Posiciona o Control no centro da tela
	#position = Vector2(viewport_size.x / 2 - size.x / 2, viewport_size.y / 2 - size.y / 2)
	#var viewport_size = get_viewport().size
	var aspect_ratio = viewport_size.x / viewport_size.y
	life_bar.scale = Vector2(aspect_ratio, aspect_ratio)  # ajusta o tamanho do sprite baseado na proporção da tela
	pass

func start_score():
	_hero = Global.hero
	life_bar_num.text = str(_hero._health, "/", _hero._health_max)
	timer_counter.text = str("%02d" % default_minutes) + ":" + str("%02d" % default_seconds)
	level.text = str("Lv." + str(_hero._level))
	preload_resources()

func preload_resources():
	_life_bar_sprites = {
		"100%":preload("res://sprites/lifebar/lifebar1.png"),
		"80%":preload("res://sprites/lifebar/lifebar2.png"),
		"60%":preload("res://sprites/lifebar/lifebar3.png"),
		"40%":preload("res://sprites/lifebar/lifebar4.png"),
		"20%":preload("res://sprites/lifebar/lifebar5.png"),
		"0%":preload("res://sprites/lifebar/lifebar6.png")
	}

# Health
func _update_health_counter():
	life_bar_num.text = str(_hero._health, "/", _hero._health_max)
	var life_bar_porc: float = _hero._health / _hero._health_max
	if life_bar_porc > 0.80:
		_update_life_bar("100%")
	elif life_bar_porc > 0.60:
		_update_life_bar('80%')
	elif life_bar_porc > 0.40:
		_update_life_bar('60%')
	elif life_bar_porc > 0.20:
		_update_life_bar('40%')
	elif life_bar_porc >= 0.00001:
		_update_life_bar('20%')
	else:
		_update_life_bar('0%')

func _update_life_bar(key):
	life_bar.texture = _life_bar_sprites[str(key)]

# Timer
func _on_clock_timer_timeout():
	seconds += 1
	if seconds == 60:
		minutes += 1
		seconds = 0
		
	timer_counter.text = str("%02d" % minutes) + ":" + str("%02d" % seconds)
	
func reset_clock_timer():
	minutes = default_minutes
	seconds = default_seconds

# Level
func update_level_count():
	level.text = str("Lv." + str(_hero._level))
