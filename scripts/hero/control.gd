extends Control

@export var default_minutes := 0
@export_range(0, 59) var default_seconds := 0
var minutes = 0
var seconds = 0

@onready var timer_counter = $TimerCounter
@onready var life_bar_num = $Hp
@onready var life_bar = $Control/LifeBar
@onready var level = $Level
@onready var skills_actives = $HudInventory/SkillsActives
@onready var skills_passives = $HudInventory/SkillsPassives
@onready var items_hud = $HudInventory/Items
@onready var items_selection = $ItemSelection
@onready var hud_inventory = $HudInventory
@onready var skill_moldure = preload("res://scenes/menus/skill_moldure.tscn")
@onready var items_moldure = preload("res://scenes/menus/item_moldure.tscn")

var items_scenes = [preload("res://scenes/items/dash_backup.tscn")]
var items_moldures = []
var items_actives = {}
var _life_bar_sprites = {}
var _hero


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

func sort_item():
	var item = items_scenes.pick_random().instantiate()
	for i in items_actives.keys():
		if item.name_item == i:
			item = items_actives[i]
	items_selection.item_sorts(item, items_moldures)

func add_items_moldures_initial():
	for i in range(3):
		var item = items_moldure.instantiate()
		item.number = i+1
		item.empty = true
		items_moldures.append(item)
		items_hud.add_child(item)

func add_item_moldure(item, number):
	match number:
		"Slot1":
			number = 0
		"Slot2":
			number = 1
		"Slot3":
			number = 2
	item.quantity += 1
	print(item.quantity)
	items_moldures[number].initialize_item(item)

func add_skill_moldure(skill, type):
	var skill_add = skill_moldure.instantiate()
	skill_add.add_icon(load(SkillsDb.SKILLS[skill.name_skill]['Icon']))
	if type == "Passive":
		skills_passives.add_child(skill_add)
	else:
		skills_actives.add_child(skill_add)

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
