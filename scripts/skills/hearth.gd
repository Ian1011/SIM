extends Node2D

var level_up_string: String = "Level_1"
var _level: int = 1
var name_skill: String = "Heart"
var enable: bool = false
var type = "Passive"

@onready var hero = Global.hero

func _ready():
		hero._health_max += 5
		hero._update_health('heal', 5)

func level_up():
	_level += 1
	level_up_string = "Level_" + str(_level+1)
	match _level:
		2:
			hero._health_max += 5
			hero._update_health('heal', 5)
		3:
			hero._health_max += 5
			hero._update_health('heal', 5)
		4:
			hero._health_max += 5
			hero._update_health('heal', 5)
		5:
			hero._health_max += 5
			hero._update_health('heal', 5)
		6:
			hero._health_max += 5
			hero._update_health('heal', 5)
		7:
			hero._health_max += 5
			hero._update_health('heal', 5)
