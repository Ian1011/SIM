extends Node2D
class_name Game

@onready var positions = $Hero/Positions
@onready var theme1 = $Theme
@onready var level_panel = $LevelUpSelection
@onready var skills_enabled = $Skills

@onready var positions_list = positions.get_children()

var game_time = 0.0
# Const
# start and end in minutesddddddddd
const SKILLS_SCENES = {
	"Skull":preload("res://scenes/weapons/skull.tscn"),
	"Sword":preload("res://scenes/weapons/sword.tscn")
}

# Funções Nativas
func _ready():
	Global.game = self
	
func _process(delta):
	game_time += delta

#Funções
func skill_upgrade():
	var i = 0
	while i < 3:
		var skill_sorted = SKILLS_SCENES.keys().pick_random()
		if not skill_sorted in skills_enabled.skills.keys():
			skill_sorted = SKILLS_SCENES[skill_sorted].instantiate()
		elif skill_sorted in skills_enabled.skills.keys():
			skill_sorted = skills_enabled.skills[str(skill_sorted)]
			if skill_sorted._level >= 7:
				continue
			skill_sorted.enable = true
		level_panel.update_labels(skill_sorted, i)
		i += 1
		
	level_panel.skill_choose()
	
func upgrade_character(item):
	skills_enabled.update_skill(item)

#Player
func _on_audio_stream_player_finished():
	theme1.play()
