extends Node2D
var skills = {
	
}

func _ready():
	var initial_skill = Global.hero.initial_skill.instantiate()
	update_skill(initial_skill)

func update_skill(skill):
	var skill_up
	if skill.enable:
		skill_up = skills[str(skill.name_skill)]
		skill_up.level_up()
	else:
		skills[str(skill.name_skill)] = skill
		skills[skill.name_skill].level_up_string = "Level_2"
		add_child(skill)
