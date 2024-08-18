extends TextureRect
var item = null
var description: String
var name_of_item: String
var mouse_over = false
@onready var item_selection = $"../../.."

signal item_selected

func _ready():
	scale = Vector2(0.438, 0.438)

func item_init(moldure):
	connect("item_selected", Callable(Global.hero,"add_item"))
	if name != "Slot4":
		item = moldure.item
	elif name == "Slot4":
		item = moldure
	name_of_item = item.name_item
	texture = load(SkillsDb.ITEMS[name_of_item]["Icon"])
	description = SkillsDb.ITEMS[name_of_item]["Description"]
	item = moldure

func item_default(defaults):
	connect("item_selected", Callable(Global.hero,"add_item"))
	name_of_item = defaults['name_default']
	description = defaults['desc_default']
	texture = defaults['icon_default']
	item = null

func _input(event):
	if mouse_over and name != "Slot4":
		if event.is_action_pressed("click"):
			emit_signal("item_selected", item, str(name))
			Global.paused_available = true
			get_tree().paused = !get_tree().paused
			item_selection.visible = false

func _on_mouse_entered():
	mouse_over = true


func _on_mouse_exited():
	mouse_over = false
