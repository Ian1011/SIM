extends TextureRect

signal selected_item

@onready var parent = $"../../.."

var description
var name_item
var icon
var mouse_over = false
var item_empty = true

func update_information(item, empty):
	self.connect("selected_item", Callable(Global.hero, "add_item_moldure"))
	item_empty = empty
	if not item_empty:
		name_item = item.name_item
		description = SkillsDb.ITEMS[name_item]["Description"]
		icon = load(SkillsDb.ITEMS[name_item]["Icon"])
	else:
		name_item = "Sem Item"
		description = "Vazio"
		icon = load("res://sprites/items/icons/placeholder.png")
	if name == "Slot4":
		parent.item_sort = item
	texture = icon

func _input(event):
	if event.is_action("click"):
		if mouse_over and name != "Slot4":
			print("Deveria funfar")
			emit_signal("selected_item", parent.item_sort, name)
			get_tree().paused = !get_tree().paused
			parent.visible = false
			Global.paused_available = true

func _on_mouse_entered():
	mouse_over = true



func _on_mouse_exited():
	mouse_over = false
