extends CanvasLayer

@onready var arrow = $ItemMenu/Icons/Arrows
@onready var icons = [$ItemMenu/Icons/Slot1, $ItemMenu/Icons/Slot2, $ItemMenu/Icons/Slot3, $ItemMenu/Icons/Slot4]
var item_sort

func _ready():
	visible = false
	var control = get_parent()
	
func item_choose():
	Global.paused_available = false
	get_tree().paused = !get_tree().paused
	visible = true

func item_sorts(item_sorted, slots):
	item_choose()
	for i in range(3):
		if slots[i].item == null:
			icons[i].update_information("", true)
		else:
			icons[i].update_information(slots[i].item, false)
	icons[3].update_information(item_sorted, false)
	

func _input(event):
	if event.is_action("up"):
		arrow_update("Slot1")
	elif event.is_action("left"):
		arrow_update("Slow4")
	elif event.is_action("right"):
		arrow_update("Slot2")
	elif event.is_action("down"):
		arrow_update("Slot3")

func arrow_update(position):
	match position:
		"Slot1":
			arrow.position = Vector2(106, 43)
			arrow.rotation = 0
		"Slot2":
			arrow.position = Vector2(225, 107)
			arrow.rotation = 80
		"Slot3":
			#arrow.position = Vector2(162, 225)
			arrow.rotation = 70
		"Slot4":
			arrow.position = Vector2(43, 162)
			arrow.rotation = 270
	print(arrow.rotation, arrow.position)
