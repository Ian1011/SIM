extends Node2D
var maxskillsActive = 5
var maxskillsPassives = 5
var maxItems = 3

var skills_actives = 0
var skills_passives = 0

var skills = {
	
}

func _ready():
	for initial_skills in Global.hero.initial_skill:
		var initial_skill = initial_skills.instantiate()
		update_skill(initial_skill, initial_skill.type)

func update_skill(skill, type):
	var skill_up
	if skill.enable:
		skill_up = skills[str(skill.name_skill)]
		skill_up.level_up()
	else:
		skills[str(skill.name_skill)] = skill
		skills[skill.name_skill].level_up_string = "Level_2"
		add_child(skill)
		Global.hero.control.add_skill_moldure(skill, type)
	if type == "Passive":
		skills_passives += 1
	else:
		skills_actives += 1
