extends Control

var empty = true
var number = 0
var quantity_item = 0
var condition = ""
var item: Node2D
@onready var quantity = $Quantity
@onready var icon = $Icon

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

func reset_moldure():
		item = null
		empty = true
		quantity.text = "0"
		icon.texture = load("res://sprites/items/icons/placeholder.png")
		icon.scale = Vector2(0.41, 0.41)

func update_carac(item):
	quantity.text = str(item.quantity)


func initialize_item(item_choose):
	item = item_choose
	icon = load(SkillsDb.ITEMS[item_choose.name_item]["Icon"])

func _input(event):
	if event.is_action_pressed(condition):
		if not empty:
			item._use_item()
			

