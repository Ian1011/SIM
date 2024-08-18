extends Node2D
class_name Game

@onready var positions = $Hero/Positions
@onready var theme1 = $Theme
@onready var level_panel = $LevelUpSelection
@onready var skills_enabled = $Skills

@onready var positions_list = positions.get_children()

var game_time = 0.0
# Const
var SKILLS_ACTIVES = {
	"Skull":preload("res://scenes/weapons/skull.tscn"),
	"Sword":preload("res://scenes/weapons/sword.tscn"),
	"Thunder":preload("res://scenes/weapons/thunder.tscn"),
	"Cyclone":preload("res://scenes/weapons/cyclone.tscn")
}
var SKILLS_PASSIVES = {
	"Heart":preload("res://scenes/weapons/heart.tscn")
}

var SKILLS_SCENES = {}

# Funções Nativas
func _ready():
	Global.game = self
	
func _process(delta):
	game_time += delta

#Funções
func skill_upgrade():
	var i = 0
	SKILLS_SCENES = {}
	if skills_enabled.skills_actives < skills_enabled.maxskillsActive and skills_enabled.skills_passives < skills_enabled.maxskillsPassives:
		SKILLS_SCENES.merge(SKILLS_ACTIVES)
		SKILLS_SCENES.merge(SKILLS_PASSIVES)
	else:
		if skills_enabled.skills_actives < skills_enabled.maxskillsActive:
			SKILLS_SCENES.merge(SKILLS_PASSIVES)
			SKILLS_SCENES.merge(skills_enabled.skills)
		elif skills_enabled.skills_passives < skills_enabled.maxskillsPassives:
			SKILLS_SCENES.merge(SKILLS_ACTIVES)
			SKILLS_SCENES.merge(skills_enabled.skills)
		else:
			SKILLS_SCENES.merge(skills_enabled.skills)

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
	
func merge_dictionaries(dict1: Dictionary, dict2: Dictionary) -> Dictionary:
	var merged_dict = {}
	for key in dict1.keys():
		merged_dict[key] = dict1[key]
	for key in dict2.keys():
		merged_dict[key] = dict2[key]
	return merged_dict
	
func upgrade_character(item, type):
	skills_enabled.update_skill(item, type)

#Player
func _on_audio_stream_player_finished():
	theme1.play()
