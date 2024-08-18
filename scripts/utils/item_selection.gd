extends CanvasLayer
@onready var slots = [$ItemMenu/Icons/Slot1, $ItemMenu/Icons/Slot2, $ItemMenu/Icons/Slot3, $ItemMenu/Icons/Slot4]
@onready var arrows = $ItemMenu/Icons/Arrows
@onready var name_item = $ItemMenu/Information/NameItem
@onready var desc_item = $ItemMenu/Information/DescItem

var defaults = {
	"name_default":"Empty",
	"desc_default":"Empty",
	"icon_default":preload("res://sprites/items/icons/placeholder.png")}

func _ready():
	arrows.pivot_offset = Vector2(28, 28)
	visible = false

func menu_init(item_sort, moldures):
	for i in range(3):
		if moldures[i].item != null:
			slots[i].item_init(moldures[i])
		else:
			slots[i].item_default(defaults)
		slots[i].item = item_sort
	slots[3].item_init(item_sort)
	Global.paused_available = false
	get_tree().paused = !get_tree().paused
	visible = true

func _input(event):
	#Logic - Arrow position = x+1, y+45. x e y position of Slot
	if event.is_action("down"):
		arrows.position = Vector2(131, 211)
		arrows.rotation_degrees = 180
		name_item.text = slots[3].name_of_item
		desc_item.text = slots[3].description
		
	elif event.is_action("left"):
		arrows.position = Vector2(45, 131)
		arrows.rotation_degrees = -90
		name_item.text = slots[2].name_of_item
		desc_item.text = slots[2].description
		
	elif event.is_action("right"):
		arrows.position = Vector2(211, 131)
		arrows.rotation_degrees = 90
		name_item.text = slots[1].name_of_item
		desc_item.text = slots[1].description
		
	elif event.is_action("up"):
		arrows.position = Vector2(131, 45)
		arrows.rotation = 0
		name_item.text = slots[0].name_of_item
		desc_item.text = slots[0].description
