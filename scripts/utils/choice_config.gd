extends Panel
var mouse_over = false
var items
signal selected_upgrade
@onready var icon = $Icon
@onready var name_skill = $Name
@onready var description = $Description
@onready var levels = $Lv
@onready var rarity = $Rarity

func _ready():
	connect("selected_upgrade",Callable(Global.hero,"add_skill"))

func update_labels(item, level, items_ins):
	name_skill.text = SkillsDb.SKILLS[item]['Name']
	levels.text = SkillsDb.SKILLS[item][level]['Lv']
	description.text = SkillsDb.SKILLS[item][level]['Description']
	rarity.text = SkillsDb.SKILLS[item][level]['Rarity']
	items = items_ins

func _input(event):
	if event.is_action("click"):
		if mouse_over:
			emit_signal("selected_upgrade", items)
			get_tree().paused = !get_tree().paused
			Global.game.level_panel.visible = false
			Global.paused_available = true
			
func _on_mouse_entered():
	mouse_over = true
	print(mouse_over)


func _on_mouse_exited():
	mouse_over = false
	print(mouse_over)
