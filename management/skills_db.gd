extends Node

const ITEM_ICON_PATH = "res://sprites/items/icons/"
const ICON_PATH = "res://sprites/weapons/icons/"

const ITEMS = {
	"Potion of Invincibility":{
		"Icon":ITEM_ICON_PATH + "invincibility.png",
		"Description":"Invincibility for a short interval"
	},
	"Potion of Strength":{
		"Icon":ITEM_ICON_PATH + "strength.png",
		"Description":"Attack +20% for a short interval"
	},
	"Potion of Speed":{
		"Icon":ITEM_ICON_PATH + "speed.png",
		"Description":"Speed +50% for a short interval"
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
	"Thunder":{
		"Name":"Thunder",
		"Icon":ICON_PATH + "thunder.png",
		"Type":"Active",
		"Level_1":{
			"Description":"Summons a thunder on a random enemy",
			"Lv":"Lv: 1"
		},
		"Level_2":{
			"Description":"Damage + 5, Thunder +1",
			"Lv":"Lv: 2"
		},
		"Level_3":{
			"Description":"Damage + 5, Thunder +1",
			"Lv":"Lv: 3"
		},
		"Level_4":{
			"Description":"Cooldown - 10%",
			"Lv":"Lv: 4"
		},
		"Level_5":{
			"Description":"Damage + 5, Thunder +1",
			"Lv":"Lv: 5"
		},
		"Level_6":{
			"Description":"Damage + 5, Thunder +1",
			"Lv":"Lv: 6"
		},
		"Level_7":{
			"Description":"Cooldown -10%",
			"Lv":"Lv: 7"
		}
	},
	"Cyclone":{
		"Name":"Cyclone",
		"Icon":ICON_PATH + "cyclone.png",
		"Type":"Active",
		"Level_1":{
			"Description":"Summons a cyclone in random direction",
			"Lv":"Lv: 1"
		},
		"Level_2":{
			"Description":"Damage +5, Cyclone +1",
			"Lv":"Lv: 2"
		},
		"Level_3":{
			"Description":"Cooldown -10%, Cyclone +1",
			"Lv":"Lv: 3"
		},
		"Level_4":{
			"Description":"Damage +5, Duration +25%",
			"Lv":"Lv: 4"
		},
		"Level_5":{
			"Description":"Damage + 5, Cyclone +1",
			"Lv":"Lv: 5"
		},
		"Level_6":{
			"Description":"Damage +5, Cyclone +1",
			"Lv":"Lv: 6"
		},
		"Level_7":{
			"Description":"Cooldown -10%, Duration +25%",
			"Lv":"Lv: 7"
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
