extends Node

const ITEM_ICON_PATH = "res://sprites/items/icons/"
const ICON_PATH = "res://sprites/weapons/icons/"

const ITEMS = {
	"Dash":{
		"Icon":ITEM_ICON_PATH + "dash.png",
		"Description":"Use a dash in the player's last direction"
	}
}

const SKILLS = {
	"Skull":{
		"Name":"Skull",
		"Icon":ICON_PATH + "skull.png",
		"Type":"Offensive",
		"Level_1":{
			"Description":"Add a skull that shoots a fire ball",
			"Lv":"Lv: 1"
		},
		"Level_2":{
			"Description":"Cooldown -0.5sec, Attack +5",
			"Lv":"Lv: 2"
		},
		"Level_3":{
			"Description":"Cooldown -0.5sec, Attack +5",
			"Lv":"Lv: 3"
		},
		"Level_4":{
			"Description":"Add another skull",
			"Lv":"Lv: 4"
		},
		"Level_5":{
			"Description":"Cooldown -0.5sec, Attack +5",
			"Lv":"Lv: 5"
		},
		"Level_6":{
			"Description":"Cooldown -0.5sec, Attack +5",
			"Lv":"Lv: 6"
		},
		"Level_7":{
			"Description":"Add another skull",
			"Lv":"Lv: 7"
		}
	},
	"Sword":{
		"Name":"Sword",
		"Icon":ICON_PATH + "sword.png",
		"Type":"Offensive",
		"Level_1":{
			"Description":"Adds a slash that deals damage to everyone in the area",
			"Lv":"Lv: 1"
		},
		"Level_2":{
			"Description":"Attack +5, Cooldown -10%",
			"Lv":"Lv: 2"
		},
		"Level_3":{
			"Description":"Attack +5, Size +10%",
			"Lv":"Lv: 3"
		},
		"Level_4":{
			"Description":"Size +10%",
			"Lv":"Lv: 4"
		},
		"Level_5":{
			"Description":"Attack +5, Cooldown -10%",
			"Lv":"Lv: 5"
		},
		"Level_6":{
			"Description":"Attack +5, Size +10%",
			"Lv":"Lv: 6"
		},
		"Level_7":{
			"Description":"Add another slash",
			"Lv":"Lv: 7"
		}
	},
	"Heart":{
		"Name":"Heart",
		"Icon":ICON_PATH + "heart.png",
		"Type":"Passive",
		"Level_1":{
			"Description":"+5 Max Health",
			"Lv":"Lv: 1"
		},
		"Level_2":{
			"Description":"+5 Max Health",
			"Lv":"Lv: 2"
		},
		"Level_3":{
			"Description":"+5 Max Health",
			"Lv":"Lv: 3"
		},
		"Level_4":{
			"Description":"+5 Max Health",
			"Lv":"Lv: 4"
		},
		"Level_5":{
			"Description":"+5 Max Health",
			"Lv":"Lv: 5"
		},
		"Level_6":{
			"Description":"+5 Max Health",
			"Lv":"Lv: 6"
		},
		"Level_7":{
			"Description":"+5 Max Health",
			"Lv":"Lv: 7",
		}
	}, 
	"Template":{
		"Name":"Template",
		"Icon":"",
		"Type":"",
		"Level_1":{
			"Description":"",
			"Lv":"Lv: 1"
		},
		"Level_2":{
			"Description":"",
			"Lv":"Lv: 2"
		},
		"Level_3":{
			"Description":"",
			"Lv":"Lv: 3"
		},
		"Level_4":{
			"Description":"",
			"Lv":"Lv: 4"
		},
		"Level_5":{
			"Description":"",
			"Lv":"Lv: 5"
		},
		"Level_6":{
			"Description":"",
			"Lv":"Lv: 6"
		},
		"Level_7":{
			"Description":"",
			"Lv":"Lv: 7"
		}
	}
}	
