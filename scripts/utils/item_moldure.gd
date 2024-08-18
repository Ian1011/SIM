extends Control

var empty = true
var in_cooldown = false
var cooldown_timer = 0
var number = 0
var quantity_item = 0
var condition = ""
var item: Node2D
var item_actived = false
@onready var quantity = $Quantity
@onready var icon = $Icon
@onready var cooldown_bar = $CooldownBar
@onready var cooldown = $Cooldown

func _ready():
	match number:
		1:
			condition = "item1"
		2:
			condition = "item2"
		3:
			condition = "item3"
	icon.texture = load("res://sprites/items/icons/placeholder.png")
	icon.scale = Vector2(0.41, 0.41)
	item = null
	set_process(false)

func _process(delta):
	if in_cooldown:
		cooldown_timer += delta
		if cooldown_timer > item.cooldown:
			cooldown_timer = item.cooldown
		cooldown_bar.value = (1 - (cooldown_timer/item.cooldown)) * 100

func reset_moldure():
		item = null
		empty = true
		quantity.text = "0"
		icon.texture = load("res://sprites/items/icons/placeholder.png")
		icon.scale = Vector2(0.41, 0.41)
		set_process(false)

func update_carac(item_quantity):
	quantity.text = str(item_quantity)

func initialize_item(item_choose, items_spawn):
	#set_process(true)
	if item != null:
		if item.name_item == item_choose.name_item:
			item.quantity += 2
			if item.quantity > 3:
				item.quantity = 3
		elif item.name_item != item_choose.name_item:
			for i in items_spawn.get_childen():
				if item.name_item == i.name_item:
					i.queue_free()
			item = null

	if item == null:
		item = item_choose
		item.quantity = 2
		icon.texture = load(SkillsDb.ITEMS[item_choose.name_item]["Icon"])
		item.moldure = self
		items_spawn.add_child(item)

	quantity.text = str(item.quantity)
	empty = false

func cooldown_start(item_cooldown):
	cooldown_bar.value = 100
	cooldown.start(item_cooldown)
	in_cooldown = true

func _input(event):
	if event.is_action_pressed(condition):
		if not empty and not in_cooldown:
			item.use_item()
			set_process(true)
			cooldown_start(item.cooldown)

func _on_cooldown_timeout():
	in_cooldown = false
	cooldown_timer = 0
	cooldown_bar.visible = false
	cooldown_bar.value = 0
	set_process(false)
