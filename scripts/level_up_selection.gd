extends CanvasLayer

@onready var choices = [$LevelUpHud/Control/Choice1, $LevelUpHud/Control/Choice2, $LevelUpHud/Control/Choice3]
func _ready():
	visible = false
	
func skill_choose():
	Global.paused_available = false
	get_tree().paused = !get_tree().paused
	visible = true

func update_labels(skill_sorted, index):
	choices[index].update_labels(skill_sorted.name_skill, skill_sorted.level_up_string, skill_sorted)
